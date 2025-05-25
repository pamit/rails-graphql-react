# query{
#   posts{
#     id
#     title
#   }
#   post(id: 1){
#     id
#     title
#   }
# }

module Resolvers
  class PostResolver < BaseResolver
    type Types::PostType, null: true

    argument :id, ID, required: true

    def resolve(id:)
      Post.find(id)
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new("Post not found")
    end
  end
end
