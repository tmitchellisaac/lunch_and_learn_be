require 'rails_helper'

describe "Get a User's Favorites Spec" do
  before(:each) do
    @user_1 = User.create!(name: "Todd", email: "cheese@gmail.com", password: 'password1', api_key: "qwertyuioplkjhgfdsazxcvb")
    @favorite_1 = Favorite.create!(user_id: @user_1.id, country: 'thailand', recipe_link: "https://www.tastingtable.com/.....", recipe_title: "You're Telling Me A Crab Fried This Rice??" )
    @favorite_2 = Favorite.create!(user_id: @user_1.id, country: 'greece', recipe_link: "https://www.tastingtable.com/.....", recipe_title: "Spanikopita" )
    @favorite_2 = Favorite.create!(user_id: @user_1.id, country: 'india', recipe_link: "https://www.tastingtable.com/.....", recipe_title: "Tandoori Chicken" )
  end

  it "gets all favorites for a user based on API key" do
  
    get  "/api/v1/favorites?api_key=qwertyuioplkjhgfdsazxcvb", headers: {"Content-Type" => "application/json", "Accept": "application/json"}
    json_response = JSON.parse(response.body, symbolize_names: true)

    expected_date = @favorite_1.created_at.utc.iso8601(3)
    expected_date_2 = @favorite_2.created_at.utc.iso8601(3)

    expect(response.status).to eq(200)
    expect(json_response[:data].count).to eq(3)
    expect(json_response[:data].first[:id]).to eq("#{@favorite_1.id}")
    expect(json_response[:data].first[:type]).to eq("favorite")
    expect(json_response[:data].first[:attributes].count).to eq(4)
    expect(json_response[:data].first[:attributes][:recipe_title]).to eq(@favorite_1.recipe_title)
    expect(json_response[:data].first[:attributes][:recipe_link]).to eq(@favorite_1.recipe_link)
    expect(json_response[:data].first[:attributes][:country]).to eq(@favorite_1.country)
    expect(json_response[:data].first[:attributes][:created_at]).to eq(expected_date)
  end

  it "returns an appropriate error if API is incorrect" do
    get  "/api/v1/favorites?api_key=boopboopwrongkey", headers: {"Content-Type" => "application/json", "Accept": "application/json"}
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(401)
    expect(json_response).to eq({:error=>{:message=>"incorrect API key", :status_code=>401}})
  end

end