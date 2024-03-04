require 'rails_helper'

describe "Air_Quality Poro" do
  it "creates a poro with correct data" do
    data_input = {:main=>{:aqi=>2},
    :components=>{:co=>300.41, :no=>0, :no2=>3.26, :o3=>90.84, :so2=>4.17, :pm2_5=>13.71, :pm10=>19.72, :nh3=>7.73},
    :dt=>1709570004}

    poro = AirQuality.new(data_input)

    expect(poro).to be_a(AirQuality)
    expect(poro.aqi).to eq(2)
    expect(poro.datetime).to eq(1709570004)
    expect(poro.id).to eq(nil)
    expect(poro.readable_aqi).to eq("Fair")
  end
end