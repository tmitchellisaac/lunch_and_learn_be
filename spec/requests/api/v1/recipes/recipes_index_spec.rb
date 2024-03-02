require 'rails_helper'

describe "Recipes API" do
  it "sends a list of recipes if country param is provided" do
    # create_list(:recipe, 3)
    q_thailand = File.read("spec/fixtures/q_thailand.json")
    stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=1c407fd5&app_key=499d33a43abe080e2f3e32e70e6cf6e7&q=thailand&type=public").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: q_thailand, headers: {})

    get "/api/v1/recipes?country=thailand", headers: {"CONTENT_TYPE" => "application/json", "Accept": "application/json"}
    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response[:data].first[:from]).to eq(nil)
    expect(json_response[:data].first[:to]).to eq(nil)
    expect(json_response[:data].first[:count]).to eq(nil)
    expect(json_response[:data].first[:hits]).to eq(nil)
    expect(json_response[:data].first).to_not eq(nil)
    expect(json_response[:data].first[:id]).to eq(nil)
    expect(json_response[:data].first[:type]).to eq("recipe")
    expect(json_response[:data].first[:attributes]).to be_a(Hash)
    expect(json_response[:data].first[:attributes][:title]).to eq("Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)")
    expect(json_response[:data].first[:attributes][:url]).to eq("https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html")
    expect(json_response[:data].first[:attributes][:country]).to eq("thailand")
    expect(json_response[:data].first[:attributes][:image]).to be_a(String)
  end

  it "searches for a random country when no 'country' param is provided " do

    one_country = File.read("spec/fixtures/one_country.json")
    stub_request(:get, "https://restcountries.com/v3.1/all?fields=name").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: one_country, headers: {})

    ethiopia_recipes = File.read("spec/fixtures/ethiopia_recipes.json")
    stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=1c407fd5&app_key=499d33a43abe080e2f3e32e70e6cf6e7&q=Ethiopia&type=public").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: ethiopia_recipes , headers: {})


    get "/api/v1/recipes", headers: {"CONTENT_TYPE" => "application/json", "Accept": "application/json"}
    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response[:data].first[:from]).to eq(nil)
    expect(json_response[:data].first[:to]).to eq(nil)
    expect(json_response[:data].first[:count]).to eq(nil)
    expect(json_response[:data].first[:hits]).to eq(nil)
    expect(json_response[:data].first).to_not eq(nil)
    expect(json_response[:data].first[:id]).to eq(nil)
    expect(json_response[:data].first[:type]).to eq("recipe")
    expect(json_response[:data].first[:attributes]).to be_a(Hash)
    expect(json_response[:data].first[:attributes][:title]).to eq("Ethiopia Coffee Pancakes With Blueberry Maple Syrup recipes")
    expect(json_response[:data].first[:attributes][:url]).to eq("http://dadwithapan.com/recipe/ethiopia-coffee-pancakes-with-blueberry-maple-syrup/")
    expect(json_response[:data].first[:attributes][:country]).to eq("Ethiopia")
    expect(json_response[:data].first[:attributes][:image]).to be_a(String)
  end


  it "returns a formatted empty data array if no recipes are found for query " do

    empty_recipe_query = File.read("spec/fixtures/empty_recipe_query.json")
    stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=1c407fd5&app_key=499d33a43abe080e2f3e32e70e6cf6e7&q=pitcairn%20islands&type=public").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: empty_recipe_query, headers: {})    

    get "/api/v1/recipes?country=pitcairn%20islands", headers: {"CONTENT_TYPE" => "application/json", "Accept": "application/json"}

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(json_response[:data]).to eq([])
  end

end