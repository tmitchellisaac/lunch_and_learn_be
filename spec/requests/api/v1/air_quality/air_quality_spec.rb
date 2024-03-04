require 'rails_helper'

describe "Weather Spec" do
  it "gets air quality info for valid country" do

    india_coordinates = File.read("spec/fixtures/india_coordinates.json")
    stub_request(:get, "https://restcountries.com/v3.1/name/India?fields=name,latlng&fullText=true").
      with(
        headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: india_coordinates, headers: {})

    india_air_quality = File.read("spec/fixtures/india_20_77_air_quality.json")
    stub_request(:get, "http://api.openweathermap.org/data/2.5/air_pollution?appid=#{Rails.application.credentials.OPEN_WEATHER[:KEY]}&lat=20.0&lon=77.0").
      with(
        headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: india_air_quality, headers: {})

    get "/api/v1/air_quality?country=India", headers: {"CONTENT_TYPE" => "application/json", "Accept": "application/json"}
    expect(response.status).to eq(200)
    expect(response).to be_successful
    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(json_response[:data].count).to eq(3)
    expect(json_response[:data][:id]).to eq(nil)
    expect(json_response[:data][:type]).to eq("air_quality")
    expect(json_response[:data][:attributes].count).to eq(3)
    expect(json_response[:data][:attributes][:aqi]).to eq(2)
    expect(json_response[:data][:attributes][:datetime]).to eq(1709570004)
    expect(json_response[:data][:attributes][:readable_aqi]).to eq("Fair")
    end

    it "gets a second valid country" do
      france_coordinates = File.read("spec/fixtures/france_coordinates.json")
      stub_request(:get, "https://restcountries.com/v3.1/name/France?fields=name,latlng&fullText=true").
        with(
          headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'User-Agent'=>'Faraday v2.9.0'
          }).
        to_return(status: 200, body: france_coordinates, headers: {})

      france_air_quality = File.read("spec/fixtures/france_46_2_air_quality.json")
      stub_request(:get, "http://api.openweathermap.org/data/2.5/air_pollution?appid=#{Rails.application.credentials.OPEN_WEATHER[:KEY]}&lat=46.0&lon=2.0").
        with(
          headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'User-Agent'=>'Faraday v2.9.0'
          }).
        to_return(status: 200, body: france_air_quality, headers: {})

      get "/api/v1/air_quality?country=France", headers: {"CONTENT_TYPE" => "application/json", "Accept": "application/json"}
      expect(response.status).to eq(200)
      expect(response).to be_successful
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:data].count).to eq(3)
      expect(json_response[:data][:id]).to eq(nil)
      expect(json_response[:data][:type]).to eq("air_quality")
      expect(json_response[:data][:attributes].count).to eq(3)
      expect(json_response[:data][:attributes][:aqi]).to eq(2)
      expect(json_response[:data][:attributes][:datetime]).to eq(1709573002)
      expect(json_response[:data][:attributes][:readable_aqi]).to eq("Fair")
    end

  end