# frozen_string_literal: true

module Types
  class BaseField < GraphQL::Schema::Field
    include ApolloFederation::Field
    argument_class Types::BaseArgument
  end
end
