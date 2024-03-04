require 'rails_helper'

describe "AirQuality Serializer" do
  it "serializes an AirQuality PORO" do

    data_input = {:main=>{:aqi=>2},
    :components=>{:co=>300.41, :no=>0, :no2=>3.26, :o3=>90.84, :so2=>4.17, :pm2_5=>13.71, :pm10=>19.72, :nh3=>7.73},
    :dt=>1709570004}

    poro = AirQuality.new(data_input)
    serializer = AirQualitySerializer.new(poro)
    expect(serializer).to be_a(AirQualitySerializer)
  end
end