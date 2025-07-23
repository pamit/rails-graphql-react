# query{
#   posts{
#     id
#     title
#   }
# }

module Resolvers
  class PostsResolver < BaseResolver
    type [ Types::PostType ], null: false

    def resolve
      Post.all.order(created_at: :asc)
    end
  end
end
