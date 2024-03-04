require 'rails_helper'

describe "AirQualityService" do
  it "gets Air quality data for a set of coordinates" do

    india_air_quality = File.read("spec/fixtures/india_20_77_air_quality.json")
    stub_request(:get, "http://api.openweathermap.org/data/2.5/air_pollution?appid=#{Rails.application.credentials.OPEN_WEATHER[:KEY]}&lat=20&lon=77").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: india_air_quality, headers: {})

    coordinates = [20,77]
    air_quality_service = AirQualityService.new
    result = air_quality_service.get_air_quality(coordinates)
    expect(result).to be_a(Hash)
    expect(result.count).to eq(3)
    expect(result[:main]).to eq({:aqi=>2})
    expect(result[:main][:aqi]).to eq(2)
    expect(result[:dt]).to eq(1709570004)
  end
end