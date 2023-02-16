<!-- README.md is generated from README.ecr, do not edit -->

# Apollo Federation Server benchmarks

This shows the benchmarks for different servers.

There are 4 services;

- [Accounts](./common/accounts.js)
- [Inventory](./common/inventory.js)
- [Products](./common/products.js)
- [Reviews](./common/reviews.js)

And the gateway receives the following complex query on every HTTP request;

```graphql
fragment User on User {
  id
  username
  name
}
fragment Review on Review {
  id
  body
}
fragment Product on Product {
  inStock
  name
  price
  shippingEstimate
  upc
  weight
}
query TestQuery {
  users {
    ...User
    reviews {
      ...Review
      product {
        ...Product
      }
    }
  }
  topProducts {
    ...Product
    reviews {
      ...Review
      author {
        ...User
      }
    }
  }
}
```

[Accounts](./common/accounts.js)

The API is served over HTTP using a common web server and load tested using [bombardier](https://github.com/codesenberg/bombardier).

### Results

| Name                          | Language      | Server          | Latency avg      | Requests      |
| ----------------------------  | ------------- | --------------- | ---------------- | ------------- |
| [GraphQL Yoga](https://github.com/dotansimha/graphql-yoga) | Node.js | http | 1,024.80ms | 84ps |
| [Apollo Server](https://github.com/apollographql/apollo-server) | Node.js | Express | 1,480.79ms | 61ps |
