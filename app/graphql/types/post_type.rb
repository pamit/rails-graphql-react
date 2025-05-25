# frozen_string_literal: true

module Types
  class PostType < Types::BaseObject
    key fields: 'id' # Apollo Federation key for PostType

    field :id, ID, null: false
    field :title, String
    field :content, String
  end
end
