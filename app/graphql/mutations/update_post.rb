# frozen_string_literal: true

module Mutations
  class UpdatePost < BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :content, String, required: false

    field :post, Types::PostType, null: false
    field :errors, [String], null: false

    def resolve(id:, title:, content:)
      post = Post.find(id)
      post.update! title: title, content: content
      post
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new("Post not found")
    end
  end
end
