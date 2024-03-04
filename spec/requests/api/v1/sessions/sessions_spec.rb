require 'rails_helper'

describe "Logging a User In" do
  it "sends back User data when they log in" do

    user = User.create!(name: "Odell", email: "goodboy@ruffruff.com", password: "treats4lyf", password_confirmation: "treats4lyf", api_key: "jgn983hy48thw9begh98h4539h4")
    user_login_data = {  
      "email": "goodboy@ruffruff.com",
      "password": "treats4lyf"
    }

    post "/api/v1/sessions", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(user_login_data)
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(200)
    expect(json_response[:data].count).to eq(3)
    expect(json_response[:data][:id]).to eq("#{user.id}")
    expect(json_response[:data][:type]).to eq("user")
    expect(json_response[:data][:attributes]).to be_a(Hash)
    expect(json_response[:data][:attributes].count).to eq(3)
    expect(json_response[:data][:attributes][:email]).to eq("goodboy@ruffruff.com")
    expect(json_response[:data][:attributes][:name]).to eq("Odell")
    expect(json_response[:data][:attributes][:api_key]).to eq("jgn983hy48thw9begh98h4539h4")
  end

  it "sends back an appropriate error if email doesn't exist/match" do
    user = User.create!(name: "Odell", email: "goodboy@ruffruff.com", password: "treats4lyf", password_confirmation: "treats4lyf", api_key: "jgn983hy48thw9begh98h4539h4")
    user_login_data = {  
      "email": "woofwoofboy@ruffruff.com",
      "password": "treats4lyf"
    }

    post "/api/v1/sessions", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(user_login_data)
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(400)
    expect(json_response[:error].count).to eq(2)
    expect(json_response[:error][:message]).to eq("invalid credentials, please try again")
    expect(json_response[:error][:status_code]).to eq(400)

  end

  it "sends back an appropriate error if password is incorrect" do
    user = User.create!(name: "Odell", email: "goodboy@ruffruff.com", password: "treats4lyf", password_confirmation: "treats4lyf", api_key: "jgn983hy48thw9begh98h4539h4")
    user_login_data = {  
      "email": "goodboy@ruffruff.com",
      "password": "treats3lyf"
    }

    post "/api/v1/sessions", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(user_login_data)
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(400)
    expect(json_response[:error].count).to eq(2)
    expect(json_response[:error][:message]).to eq("invalid credentials, please try again")
    expect(json_response[:error][:status_code]).to eq(400)
  end
end