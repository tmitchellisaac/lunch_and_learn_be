require 'rails_helper'

describe "AirQuality Facade" do
  before(:each) do
    @aq_facade = AirQualityFacade.new("India")
  end

  it "gets coordinates for a country (official name)" do
    india_coordinates = File.read("spec/fixtures/india_coordinates.json")
    stub_request(:get, "https://restcountries.com/v3.1/name/India?fields=name,latlng&fullText=true").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: india_coordinates, headers: {})

    expect(@aq_facade.get_coordinates).to eq([20.0, 77.0])
  end

  it "gets Air quality data for a set of coordinates" do
    india_air_quality = File.read("spec/fixtures/india_20_77_air_quality.json")
    stub_request(:get, "http://api.openweathermap.org/data/2.5/air_pollution?appid=#{Rails.application.credentials.OPEN_WEATHER[:KEY]}&lat=20.0&lon=77.0").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: india_air_quality, headers: {})

    result = @aq_facade.air_quality([20.0, 77.0])

    expect(result.count).to eq(3)
    expect(result[:main][:aqi]).to eq(2)
    expect(result[:dt]).to eq(1709570004)
  end

  it "combines the air_quality and get_coordinates method to produce a poro" do
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

    poro = @aq_facade.big_air_quality
    expect(poro).to be_a(AirQuality)
    expect(poro.aqi).to eq(2)
    expect(poro.datetime).to eq(1709570004)
    expect(poro.id).to eq(nil)
    expect(poro.readable_aqi).to eq("Fair")
  end

  it "creates an AirQuality Service" do
    expect(@aq_facade.air_quality_service).to be_a(AirQualityService)
  end

  it "creates an Country Service" do
    expect(@aq_facade.country_service).to be_a(CountryService)
  end
end