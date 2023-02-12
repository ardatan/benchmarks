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
| [GraphQL Yoga on Bun](https://github.com/dotansimha/graphql-yoga) | Bun | http | 4.66ms | 21kps |
| [Mercurius](https://github.com/mercurius-js/mercurius) | Node.js | Fastify | 7.84ms | 13kps |
| [Hono](https://github.com/honojs/graphql-server) | Bun | HonoJS | 13.03ms | 7.7kps |
| [GraphQL Yoga on Node](https://github.com/dotansimha/graphql-yoga) | Node.js | http | 15.29ms | 6.5kps |
| [graphql-jit](https://github.com/zalando-incubator/graphql-jit) | Node.js | http | 18.83ms | 5.3kps |
| [apollo](https://github.com/apollographql/apollo-server) | Node.js | Express | 33.09ms | 3.0kps |
| [graphql-js](https://github.com/graphql/graphql-js) | Node.js | http | 39.26ms | 2.5kps |
