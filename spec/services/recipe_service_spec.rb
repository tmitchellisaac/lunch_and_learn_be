require 'rails_helper'

describe "Recipe Service" do
  it "gets recipes --> #get_recipe" do

  ethiopia_recipes = File.read("spec/fixtures/ethiopia_recipes.json")
  stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=1c407fd5&app_key=#{Rails.application.credentials.EDAMAM[:EDAMAM_KEY]}&q=Ethiopia&type=public").
    with(
      headers: {
    'Accept'=>'*/*',
    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: ethiopia_recipes, headers: {})

  recipe_service = RecipeService.new
  results = recipe_service.get_recipes("Ethiopia")

  expect(results.count).to eq(18)
  expect(results.first.count).to eq(2)
  expect(results.first[:recipe].count).to eq(25)
  expect(results.first[:recipe][:uri]).to eq("http://www.edamam.com/ontologies/edamam.owl#recipe_c4a41126c298c233bd8fe30444405670")
  expect(results.first[:recipe][:label]).to eq("Ethiopia Coffee Pancakes With Blueberry Maple Syrup recipes")
  expect(results.first[:recipe][:url]).to eq("http://dadwithapan.com/recipe/ethiopia-coffee-pancakes-with-blueberry-maple-syrup/")

  end
end