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
| [GraphQL Yoga on Bun](https://github.com/dotansimha/graphql-yoga) | Bun | http | 5.35ms | 19kps |
| [Mercurius](https://github.com/mercurius-js/mercurius) | Node.js | Fastify | 5.91ms | 17kps |
| [Hono](https://github.com/honojs/graphql-server) | Bun | HonoJS | 11.68ms | 8.6kps |
| [GraphQL Yoga on Node](https://github.com/dotansimha/graphql-yoga) | Node.js | http | 12.37ms | 8.1kps |
| [graphql-jit](https://github.com/zalando-incubator/graphql-jit) | Node.js | http | 14.51ms | 6.9kps |
| [apollo](https://github.com/apollographql/apollo-server) | Node.js | Express | 25.46ms | 3.9kps |
| [graphql-js](https://github.com/graphql/graphql-js) | Node.js | http | 38.78ms | 2.6kps |
