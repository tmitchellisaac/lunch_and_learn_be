require 'rails_helper'

describe "Recipe Facade" do
  before(:each) do
    @recipe_facade = RecipeFacade.new(country: "Ethiopia")
    @recipe_facade_2 = RecipeFacade.new(country: "")
  end

  it "gets recipes after selecting country input --> #recipes" do
    ethiopia_recipes = File.read("spec/fixtures/ethiopia_recipes.json")
    stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=1c407fd5&app_key=#{Rails.application.credentials.EDAMAM[:EDAMAM_KEY]}&q=Ethiopia&type=public").
      with(
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: ethiopia_recipes, headers: {})

    result = @recipe_facade.recipes
    expect(result).to be_a(Array)
    expect(result.count).to eq(18)
    expect(result.first.id).to eq(nil)
    expect(result.first.image).to_not eq(nil)
    expect(result.first.title).to eq("Ethiopia Coffee Pancakes With Blueberry Maple Syrup recipes")
    expect(result.first.country).to eq("Ethiopia")
    expect(result.first.url).to_not eq(nil)

    expect(result.second.id).to eq(nil)
    expect(result.second.image).to_not eq(nil)
    expect(result.second.title).to eq("Sunshine Coffee")
    expect(result.second.country).to eq("Ethiopia")
    expect(result.second.url).to_not eq(nil)
  end

  it "[SAD-ish?] gets recipes if there is no country input --> #recipes" do
    ethiopia_recipes = File.read("spec/fixtures/ethiopia_recipes.json")
    stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=1c407fd5&app_key=#{Rails.application.credentials.EDAMAM[:EDAMAM_KEY]}&q=Ethiopia&type=public").
      with(
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: ethiopia_recipes, headers: {})

  
    one_country = File.read("spec/fixtures/one_country.json")
    stub_request(:get, "https://restcountries.com/v3.1/all?fields=name").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: one_country, headers: {})

    result = @recipe_facade_2.recipes
    expect(result).to be_a(Array)
    expect(result.count).to eq(18)
    expect(result.first.id).to eq(nil)
    expect(result.first.image).to_not eq(nil)
    expect(result.first.title).to eq("Ethiopia Coffee Pancakes With Blueberry Maple Syrup recipes")
    expect(result.first.country).to eq("Ethiopia")
    expect(result.first.url).to_not eq(nil)

    expect(result.second.id).to eq(nil)
    expect(result.second.image).to_not eq(nil)
    expect(result.second.title).to eq("Sunshine Coffee")
    expect(result.second.country).to eq("Ethiopia")
    expect(result.second.url).to_not eq(nil)
  end

  it "gets recipes from a selected country, creates PORO --> #recipes_small" do
    ethiopia_recipes = File.read("spec/fixtures/ethiopia_recipes.json")
    stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=1c407fd5&app_key=#{Rails.application.credentials.EDAMAM[:EDAMAM_KEY]}&q=Ethiopia&type=public").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: ethiopia_recipes, headers: {})

    result = @recipe_facade.recipes_small("Ethiopia")

    expect(result.count).to eq(18)

    expect(result.first).to be_a(Recipe)
    expect(result.first.id).to eq(nil)
    expect(result.first.title).to eq("Ethiopia Coffee Pancakes With Blueberry Maple Syrup recipes")
    expect(result.first.country).to eq("Ethiopia")
    expect(result.first.url).to_not eq(nil)

    expect(result.second).to be_a(Recipe)
    expect(result.second.id).to eq(nil)
    expect(result.second.title).to eq("Sunshine Coffee")
    expect(result.second.country).to eq("Ethiopia")
    expect(result.second.url).to_not eq(nil)
  end

  it "selects a random country --> #random_country" do
    one_country = File.read("spec/fixtures/one_country.json")
    stub_request(:get, "https://restcountries.com/v3.1/all?fields=name").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: one_country, headers: {})

    result = @recipe_facade_2.random_country

    expect(result).to eq("Ethiopia")
  end

  it "creates a recipe service --> #service" do
    expect(@recipe_facade.service).to be_a(RecipeService)
  end

end