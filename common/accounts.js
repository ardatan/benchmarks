import { gql } from "graphql-tag";
import { buildSubgraphSchema } from "@apollo/subgraph";

const typeDefs = gql`
  extend type Query {
    me: User
    users: [User]
  }

  type User @key(fields: "id") {
    id: ID!
    name: String
    username: String
  }
`;

const resolvers = {
  Query: {
    me() {
      return users[0];
    },
    users() {
      return users;
    },
  },
  User: {
    __resolveReference(object) {
      return users.find((user) => user.id === object.id);
    },
  },
};

const users = [
  {
    id: "1",
    name: "Ada Lovelace",
    birthDate: "1815-12-10",
    username: "@ada",
  },
  {
    id: "2",
    name: "Alan Turing",
    birthDate: "1912-06-23",
    username: "@complete",
  },
];

export const accountsSchema = buildSubgraphSchema([
  {
    typeDefs,
    resolvers,
  },
]);
