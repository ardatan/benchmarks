<!-- README.md is generated from README.ecr, do not edit -->

# GraphQL server benchmarks

Graphql server benchmarks in many languages. Pull requests welcome, please read [CONTRIBUTING.md](CONTRIBUTING.md)

All servers implement a simple schema:

```graphql
type Query {
  hello: String!
}
```

The returned string is always `world`.

The API is served over HTTP using a common web server and load tested using [bombardier](https://github.com/codesenberg/bombardier).

### Results

| Name                          | Language      | Server          | Latency avg      | Requests      |
| ----------------------------  | ------------- | --------------- | ---------------- | ------------- |
| [GraphQL Yoga on Bun](https://github.com/dotansimha/graphql-yoga) | Bun | http | 4.30ms | 23kps |
| [Mercurius](https://github.com/mercurius-js/mercurius) | Node.js | Fastify | 5.93ms | 17kps |
| [Hono](https://github.com/honojs/graphql-server) | Bun | HonoJS | 11.45ms | 8.7kps |
| [GraphQL Yoga on Node](https://github.com/dotansimha/graphql-yoga) | Node.js | http | 11.98ms | 8.3kps |
| [graphql-jit](https://github.com/zalando-incubator/graphql-jit) | Node.js | http | 15.58ms | 6.4kps |
| [apollo](https://github.com/apollographql/apollo-server) | Node.js | Express | 24.64ms | 4.0kps |
| [graphql-js](https://github.com/graphql/graphql-js) | Node.js | http | 32.66ms | 3.1kps |
