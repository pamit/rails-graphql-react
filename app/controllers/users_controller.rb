class UsersController < ApplicationController
  def index
    render json: [
      { id: 1, name: 'John Doe'},
      { id: 2, name: 'John Smith'},
    ]
  end
end
