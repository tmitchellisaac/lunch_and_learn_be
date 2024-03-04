require 'rails_helper'

describe "CountryService" do
  it "gets coordinates for a country" do
    india_coordinates = File.read("spec/fixtures/india_coordinates.json")
    stub_request(:get, "https://restcountries.com/v3.1/name/India?fields=name,latlng&fullText=true").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: india_coordinates, headers: {})

    country_service = CountryService.new
    response = country_service.get_coordinates('India')
    expect(response).to eq([20.0, 77.0])

  end

  it "gets all countries (to be then chosen randomly from)" do

    all_countries = File.read("spec/fixtures/all_countries_name.json")
    stub_request(:get, "https://restcountries.com/v3.1/all?fields=name").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: all_countries, headers: {})

    country_service = CountryService.new
    response = country_service.get_country
    expect(response.count).to eq(250)
    expect(response.first[:name].count).to eq(3)
    expect(response.first[:name][:common]).to eq("Cyprus")
    expect(response.first[:name][:official]).to eq("Republic of Cyprus")

    expect(response.second[:name].count).to eq(3)
    expect(response.second[:name][:common]).to eq("Eritrea")
    expect(response.second[:name][:official]).to eq("State of Eritrea")
  end

end