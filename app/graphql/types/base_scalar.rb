# frozen_string_literal: true

module Types
  class BaseScalar < GraphQL::Schema::Scalar
    include ApolloFederation::Scalar
  end
end
