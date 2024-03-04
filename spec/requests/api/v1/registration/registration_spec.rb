require 'rails_helper'

describe "User Registration" do
  it "sends learning resources if country param is provided" do
  
    user_data = {  
      "name": "Odell",
      "email": "goodboy@ruffruff.com",
      "password": "treats4lyf",
      "password_confirmation": "treats4lyf"
    }

    post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(user_data)

    expect(response).to be_successful
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(json_response[:data]).to be_a(Hash)
    expect(json_response[:data].count).to eq(3)
    expect(json_response[:data][:user]).to eq(nil)
    expect(json_response[:data][:type]).to eq("user")
    expect(json_response[:data][:attributes]).to be_a(Hash)
    expect(json_response[:data][:attributes].count).to eq(3)
    expect(json_response[:data][:attributes][:email]).to eq("goodboy@ruffruff.com")
    expect(json_response[:data][:attributes][:name]).to eq("Odell")
    expect(json_response[:data][:attributes][:api_key].size).to eq(24)
  end

  it " returns an appropriate error message if password does not match" do
    user_data = {  
      "name": "Odell",
      "email": "goodboy@ruffruff.com",
      "password": "treats4lyf",
      "password_confirmation": "treats3lyf"
    }
    post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(user_data)
    
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(400)
    expect(json_response[:error].count).to eq(2)
    expect(json_response[:error][:message]).to eq("invalid credentials, please try again")
    expect(json_response[:error][:status_code]).to eq(400)
  end

  it " returns an appropriate error message if email is not unique" do
    user_data = {  
      "name": "Odell",
      "email": "goodboy@ruffruff.com",
      "password": "treats4lyf",
      "password_confirmation": "treats4lyf"
    }

    post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(user_data)
    expect(response).to be_successful

    user_data = {  
      "name": "Graham",
      "email": "goodboy@ruffruff.com",
      "password": "password1",
      "password_confirmation": "password1"
    }
    post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(user_data)

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(400)
    expect(json_response[:error].count).to eq(2)
    expect(json_response[:error][:message]).to eq("email is not unique")
    expect(json_response[:error][:status_code]).to eq(400)
  end

end