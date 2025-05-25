module Resolvers
  class PostsResolver < BaseResolver
    type [Types::PostType], null: false

    def resolve
      Post.all.order(created_at: :desc)
    end
  end
end
