#!/usr/bin/env crystal
require "socket"
require "http"
require "json"
require "yaml"
require "ecr"

benchmarks = Array(Benchmark).from_yaml ECR.render("benchmarks.yaml")

shards_mut = Mutex.new

ch = Channel(Nil).new
benchmarks.map do |b|
  spawn do
    dir = Path[Dir.current, b.id]
    if File.exists? dir.join("shard.yml")
      shards_mut.synchronize do
        run("shards", ["install", "-q", "--frozen"], dir, true)
      end
    end
    run("crystal", ["build", "--release", "-D", "preview_mt", "main.cr"], dir, true) if File.exists? dir.join("shard.yml")
    run("npm", ["ci", "--silent"], dir, true) if File.exists? dir.join("package.json")
    run("cargo", ["build", "--release", "--quiet"], dir, true) if File.exists? dir.join("Cargo.toml")
    run("go", ["build", "-o", "main", "main.go"], dir, true) if File.exists? dir.join("go.mod")
    run("pipenv", ["install"], dir, true) if File.exists? dir.join("Pipfile")
    run("sbt", ["--warn", "compile", "assembly"], dir, true) if File.exists? dir.join("build.sbt")
    run("bundle", ["install", "--quiet"], dir, true) if File.exists? dir.join("Gemfile")
    run("mix", ["deps.get", "--only", "prod"], dir, true) if File.exists? dir.join("mix.exs")
    run("mix", ["compile"], dir, true) if File.exists? dir.join("mix.exs")
    run("nimble", ["--silent", "-y", "install"], dir, true) if File.exists? dir.join("main.nimble")
    run("nimble", ["--silent", "-y", "build", "-d:release", "-d:chronicles_log_level=WARN"], dir, true) if File.exists? dir.join("main.nimble")
    ch.send(nil)
  rescue ex
    puts ex.message
    exit 1
  end
end.each { |_| ch.receive }

benchmarks.each_with_index do |b, i|
  if port_bound?
    # a TERM signal doesn't always end all processes
    # some servers take many seconds to terminate, and python doesn't terminate since we started using `pipenv run`
    # there may be a proper solution for each case, but for now we use fuser as a workaround
    system("fuser -k 8000/tcp")
    raise "port 8000 already in use" unless wait_unbound 60
    puts "killed socket process"
  end

  puts "running #{b.id}..."

  p = run(b.run.cmd, b.run.args, Path[Dir.current, b.id])

  while !port_bound?
    exit 1 if p.terminated?
    sleep 1
  end

  res = `bombardier -c #{System.cpu_count * 50} -d 5s -m POST -b '{"query":"{ hello }"}' -H "Content-Type: application/json" -o json -p r http://localhost:8000/graphql`
  exit 1 unless $?.success?

  p.terminate
  r = p.wait
  if r.exit_code != 0
    puts "command failed with exit code #{r.exit_code}"
    exit 1
  end

  benchmarks[i].result = JSON.parse(res.split('\n').last)["result"]
end

benchmarks = benchmarks.sort do |a, b|
  b.result.not_nil!.["rps"]["mean"].as_f <=> a.result.not_nil!.["rps"]["mean"].as_f
end
readme = ECR.render("README.ecr")
File.write "README.md", readme
puts readme

def run(cmd, args, dir, wait = false)
  env = {"CRYSTAL_WORKERS" => System.cpu_count.to_s, "MIX_ENV" => "prod", "MIX_QUIET" => "1", "PORT" => "8000"}
  p = Process.new(cmd, env: env, args: args, input: Process::Redirect::Inherit, output: Process::Redirect::Inherit, error: Process::Redirect::Inherit, chdir: dir.to_s)
  at_exit { p.terminate unless p.terminated? }
  if wait
    r = p.wait
    if r.exit_code != 0
      puts "#{dir}: command '#{cmd}' failed with exit code #{r.exit_code}"
      exit 1
    end
  end
  p
end

def wait_unbound(time : Int32)
  if port_bound?
    if time > 0
      sleep 1
      wait_unbound time - 1
    else
      false
    end
  else
    true
  end
end

def port_bound?
  s = TCPServer.new("127.0.0.1", 8000)
  s.close
  false
rescue Socket::BindError
  true
end

class Benchmark
  include YAML::Serializable

  class Script
    include YAML::Serializable

    property cmd : String
    property args : Array(String)?
  end

  property id : String
  property name : String
  property url : String
  property lang : String
  property server : String
  property run : Script

  @[YAML::Field(ignore: true)]
  property result : JSON::Any?

  def reqs
    "#{@result.not_nil!.["rps"]["mean"].as_f.humanize(2)}ps"
  end

  def latency
    ms = @result.not_nil!.["latency"]["mean"].as_f / 1000
    "#{ms.format(decimal_places: 2)}ms"
  end
end
