# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Post.create! title: 'Learn React + Rails + GraphQL', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam lectus, congue vel laoreet ac, dictum vitae odio. Maecenas nec enim et nunc efficitur facilisis. Donec in ligula ut nisi convallis tincidunt. Donec id ligula at nunc fringilla lacinia. Curabitur non dui sed erat facilisis varius. Sed euismod, nunc eget facilisis tincidunt, nunc nisl aliquet nunc, eget aliquam nisl nisl eget nunc. Donec in ligula ut nisi convallis tincidunt. Donec id ligula at nunc fringilla lacinia.'

Post.create! title: 'React for dummies', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam lectus, congue vel laoreet ac, dictum vitae odio. Maecenas nec enim et nunc efficitur facilisis. Donec in ligula ut nisi convallis tincidunt. Donec id ligula at nunc fringilla lacinia. Curabitur non dui sed erat facilisis varius. Sed euismod, nunc eget facilisis tincidunt, nunc nisl aliquet nunc, eget aliquam nisl nisl eget nunc. Donec in ligula ut nisi convallis tincidunt. Donec id ligula at nunc fringilla lacinia.'

Post.create! title: 'GraphQL for dummies', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam lectus, congue vel laoreet ac, dictum vitae odio. Maecenas nec enim et nunc efficitur facilisis. Donec in ligula ut nisi convallis tincidunt. Donec id ligula at nunc fringilla lacinia. Curabitur non dui sed erat facilisis varius. Sed euismod, nunc eget facilisis tincidunt, nunc nisl aliquet nunc, eget aliquam nisl nisl eget nunc. Donec in ligula ut nisi convallis tincidunt. Donec id ligula at nunc fringilla lacinia.'

Post.create! title: 'Rails for dummies', content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam lectus, congue vel laoreet ac, dictum vitae odio. Maecenas nec enim et nunc efficitur facilisis. Donec in ligula ut nisi convallis tincidunt. Donec id ligula at nunc fringilla lacinia. Curabitur non dui sed erat facilisis varius. Sed euismod, nunc eget facilisis tincidunt, nunc nisl aliquet nunc, eget aliquam nisl nisl eget nunc. Donec in ligula ut nisi convallis tincidunt. Donec id ligula at nunc fringilla lacinia.'
