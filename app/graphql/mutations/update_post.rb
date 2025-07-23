# frozen_string_literal: true

# mutation {
#   updatePost(input: {
#     id: 1,
#     title: "XYZ",
#     content: "..."
#     view_count: 1,
#   }) {
#     post {
#       id
#       title
#       content
#       view_count
#     }
#     errors
#   }
# }

module Mutations
  class UpdatePost < BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :content, String, required: false
    argument :view_count, Int, required: false

    field :post, Types::PostType, null: false
    field :errors, [ String ], null: false

    def resolve(id:, title:, content:, view_count:)
      post = Post.find(id)
      if post.update title: title, content: content, view_count: view_count
        { post: post, errors: [] }
      else
        { post: nil, errors: post.errors.full_messages }
      end
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new("Post not found!")
    end
  end
end
