# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin Ajax requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "*"
    # origins "http://localhost:3001"
    # origins "http://react-app-alb-1864150578.ap-southeast-2.elb.amazonaws.com"

    resource "*",
      headers: :any,
      methods: [ :get, :post, :options ],
      credentials: false
  end
end
