# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


user_1 = User.create!(name: "Todd", email: "cheese@gmail.com", password: 'password1', api_key: "qwertyuioplkjhgfdsazxcvb")
favorite_1 = Favorite.create!(user_id: user_1.id, country: 'thailand', recipe_link: "https://www.tastingtable.com/.....", recipe_title: "You're Telling Me A Crab Fried This Rice??" )
favorite_2 = Favorite.create!(user_id: user_1.id, country: 'greece', recipe_link: "https://www.tastingtable.com/.....", recipe_title: "Spanikopita" )
favorite_2 = Favorite.create!(user_id: user_1.id, country: 'india', recipe_link: "https://www.tastingtable.com/.....", recipe_title: "Tandoori Chicken" )

user_2 = User.create!(name: "Wanda", email: "grapes@gmail.com", password: 'password1', api_key: "bvcxzasdfghjklpoiuytrewq")
