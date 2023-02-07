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
| [Mercurius](https://github.com/mercurius-js/mercurius) | Node.js | Fastify | 8.25ms | 12kps |
| [Hono](https://github.com/honojs/graphql-server) | Bun | HonoJS | 13.94ms | 7.2kps |
| [graphql-jit](https://github.com/zalando-incubator/graphql-jit) | Node.js | http | 18.13ms | 5.5kps |
| [GraphQL Yoga on Node](https://github.com/dotansimha/graphql-yoga) | Node.js | http | 20.97ms | 4.8kps |
| [apollo](https://github.com/apollographql/apollo-server) | Node.js | Express | 32.87ms | 3.0kps |
| [graphql-js](https://github.com/graphql/graphql-js) | Node.js | http | 48.96ms | 2.0kps |
