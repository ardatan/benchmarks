<!-- README.md is generated from README.ecr, do not edit -->

# Apollo Federation Server benchmarks

The returned string is always `world`.

The API is served over HTTP using a common web server and load tested using [bombardier](https://github.com/codesenberg/bombardier).

### Results

| Name                          | Language      | Server          | Latency avg      | Requests      |
| ----------------------------  | ------------- | --------------- | ---------------- | ------------- |
| [GraphQL Yoga](https://github.com/dotansimha/graphql-yoga) | Node.js | http | 796.62ms | 110ps |
| [Apollo Server](https://github.com/apollographql/apollo-server) | Node.js | Express | 1,234.66ms | 63ps |
