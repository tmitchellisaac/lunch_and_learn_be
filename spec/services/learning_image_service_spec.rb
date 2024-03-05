require 'rails_helper'

describe "Learning Image Service" do
  it "gets images based on a country --> #get_learning_image" do

  laos_images = File.read("spec/fixtures/laos_images.json")
    stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{Rails.application.credentials.UNSPLASH[:ACCESS_KEY]}&page=1&page_size=10&query=Laos").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: laos_images, headers: {})

    learning_image_service = LearningImageService.new
    result = learning_image_service.get_learning_images("Laos")
    
    expect(result.count).to eq(10)
    expect(result.first.count).to eq(21)
    expect(result.first[:id]).to eq("yJ2SHIpNb9M")
    expect(result.first[:slug]).to eq("time-lapse-photography-of-flying-hot-air-balloon-yJ2SHIpNb9M")
    expect(result.first[:width]).to eq(3888)
    expect(result.first[:description]).to eq("The picture taken in Laos, 06:00, from hot baloon")
    expect(result.first[:alt_description]).to eq("time lapse photography of flying hot air balloon")
    expect(result.first[:urls][:full]).to eq("https://images.unsplash.com/photo-1540611025311-01df3cef54b5?crop=entropy&cs=srgb&fm=jpg&ixid=M3w1NzQzNjV8MHwxfHNlYXJjaHwxfHxsYW9zfGVufDB8fHx8MTcwOTQyNzIyOHww&ixlib=rb-4.0.3&q=85")
  end
end