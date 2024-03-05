require 'rails_helper'

describe "Get a User's Favorites Spec" do
  it "gets all favorites for a user based on API key" do
    user_1 = User.create!(name: "Todd", email: "cheese@gmail.com", password: 'password1', api_key: "qwertyuioplkjhgfdsazxcvb")
    favorite_1 = Favorite.create!(user_id: user_1.id, country: 'thailand', recipe_link: "https://www.tastingtable.com/.....", recipe_title: "You're Telling Me A Crab Fried This Rice??" )
    favorite_2 = Favorite.create!(user_id: user_1.id, country: 'greece', recipe_link: "https://www.tastingtable.com/.....", recipe_title: "Spanikopita" )
    favorite_2 = Favorite.create!(user_id: user_1.id, country: 'india', recipe_link: "https://www.tastingtable.com/.....", recipe_title: "Tandoori Chicken" )

    get  "/api/v1/favorites?api_key=qwertyuioplkjhgfdsazxcvb", headers: {"Content-Type" => "application/json", "Accept": "application/json"}

    end
  end