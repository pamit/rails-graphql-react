# frozen_string_literal: true

module Types
  class BaseInputObject < GraphQL::Schema::InputObject
    include ApolloFederation::InputObject
    argument_class Types::BaseArgument
  end
end
