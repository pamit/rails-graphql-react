# frozen_string_literal: true

module Types
  class BaseUnion < GraphQL::Schema::Union
    include ApolloFederation::Union
    edge_type_class(Types::BaseEdge)
    connection_type_class(Types::BaseConnection)
  end
end
