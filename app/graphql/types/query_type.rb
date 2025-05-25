# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :posts, resolver: Resolvers::PostsResolver
    field :post, resolver: Resolvers::PostResolver

    # # TODO: remove me
    # field :test_field, String, null: false,
    #   description: "An example field added by the generator"
    # def test_field
    #   "Hello World!"
    # end
  end
end
