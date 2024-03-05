require 'rails_helper'

describe "Deletes a user's favorites" do
  before(:each) do
    @user_1 = User.create!(name: "Todd", email: "cheese@gmail.com", password: 'password1', api_key: "qwertyuioplkjhgfdsazxcvb")
    @favorite_1 = Favorite.create!(id: 1, user_id: @user_1.id, country: 'thailand', recipe_link: "https://www.tastingtable.com/.....", recipe_title: "You're Telling Me A Crab Fried This Rice??")
    @favorite_2 = Favorite.create!(id: 2, user_id: @user_1.id, country: 'greece', recipe_link: "https://www.tastingtable.com/.....", recipe_title: "Spanikopita")
    @favorite_3 = Favorite.create!(id: 3, user_id: @user_1.id, country: 'india', recipe_link: "https://www.tastingtable.com/.....", recipe_title: "Tandoori Chicken")
  end

  it "deletes a favorite for a given user with correct api key" do
  
    favorite_data = {
      "api_key": "qwertyuioplkjhgfdsazxcvb",
      "favorite_id": 1
    }

    delete "/api/v1/favorites", headers: {"CONTENT_TYPE" => "application/json", "Accept": "application/json"}, params: JSON.generate(favorite_data)
   
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200) #because I couldn't send a message back if it was 204
    expect(json_response[:success]).to eq("Favorite successfully deleted")
    expect(json_response.count).to eq(1)

  end

  it "returns the appropriate error if API is incorrect when trying to delete" do
    favorite_data = {
      "api_key": "boopboopwrongkey",
      "favorite_id": 3
    }

    delete "/api/v1/favorites", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(favorite_data)

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(401)
    expect(json_response[:success]).to eq(nil)
    expect(json_response.count).to eq(1)
    expect(json_response[:error]).to eq({
      "message": "incorrect API key",
      "status_code": 401
      })
    expect(json_response[:error][:message]).to eq("incorrect API key")
    expect(json_response[:error][:status_code]).to eq(401)

  end
end