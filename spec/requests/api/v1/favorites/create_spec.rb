require 'rails_helper'

describe "Create a Favorite Spec" do
  it "creates a favorite for a user based on API key" do
    user_1 = User.create!(name: "Todd", email: "cheese@gmail.com", password: 'password1', api_key: "qwertyuioplkjhgfdsazxcvb")
    
    favorite_data = {
        "api_key": "qwertyuioplkjhgfdsazxcvb",
        "country": "greece",
        "recipe_link": "https://www.tastingtable.com/.....",
        "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
    }
    post "/api/v1/favorites", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(favorite_data)

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response.count).to eq(1)
    expect(json_response[:success]).to eq("Favorite added successfully")
  end

  it "returns appropriate message if API doesn't match/exist" do
    user_1 = User.create!(name: "Todd", email: "cheese@gmail.com", password: 'password1', api_key: "qwertyuioplkjhgfdsazxcvb")
    
    favorite_data = {
        "api_key": "boopboopwrongapikey",
        "country": "thailand",
        "recipe_link": "https://www.tastingtable.com/.....",
        "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
    }
    post "/api/v1/favorites", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(favorite_data)

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(401)
    expect(json_response.count).to eq(1)
    expect(json_response[:error]).to eq({:message=>"incorrect API key", :status_code=>401})
    expect(json_response[:error][:message]).to eq("incorrect API key")
    expect(json_response[:error][:status_code]).to eq(401)
  end
end