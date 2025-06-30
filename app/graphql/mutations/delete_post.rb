# frozen_string_literal: true

# mutation {
#   deletePost(input: {
#     id: 1
#   }) {
#     success
#     errors
#   }
# }

module Mutations
  class DeletePost < BaseMutation
    argument :id, ID, required: true

    field :success, Boolean, null: false
    field :errors, [String], null: false

    def resolve(id:)
      post = Post.find(id)
      if post.destroy
        { success: true, errors: [] }
      else
        { success: false, errors: post.errors.full_messages }
      end
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new("Post not found!")
    end
  end
end
