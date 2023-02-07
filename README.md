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
| [GraphQL Yoga on Bun](https://github.com/dotansimha/graphql-yoga) | Bun | http | 4.23ms | 24kps |
| [Mercurius](https://github.com/mercurius-js/mercurius) | Node.js | Fastify | 5.48ms | 18kps |
| [Hono](https://github.com/honojs/graphql-server) | Bun | HonoJS | 11.48ms | 8.7kps |
| [graphql-jit](https://github.com/zalando-incubator/graphql-jit) | Node.js | http | 14.68ms | 6.8kps |
| [GraphQL Yoga on Node](https://github.com/dotansimha/graphql-yoga) | Node.js | http | 15.35ms | 6.5kps |
| [apollo](https://github.com/apollographql/apollo-server) | Node.js | Express | 24.99ms | 4.0kps |
| [graphql-js](https://github.com/graphql/graphql-js) | Node.js | http | 42.50ms | 2.3kps |
