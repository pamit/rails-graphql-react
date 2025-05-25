# frozen_string_literal: true

module Mutations
  class DeletePost < BaseMutation
    argument :id, ID, required: true

    field :post, Types::PostType, null: false
    field :errors, [String], null: false

    def resolve(id:)
      Post.find(id).destroy
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new("Post not found")
    end
  end
end
