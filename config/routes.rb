Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "users", to: "users#index"

  post "/graphql", to: "graphql#execute"

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"
  end
end
