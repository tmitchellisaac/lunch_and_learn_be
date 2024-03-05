require 'rails_helper'

describe "Learning Resources API" do
  it "sends learning resources if country param is provided" do
    learning_video_laos = File.read("spec/fixtures/learning_laos_video.json")
    stub_request(:get, "https://youtube.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{Rails.application.credentials.YOUTUBE[:KEY]}&maxResults=1&part=snippet&q=laos").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: learning_video_laos, headers: {})

    learning_image_laos = File.read("spec/fixtures/laos_images.json")
    stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{Rails.application.credentials.UNSPLASH[:ACCESS_KEY]}&page=1&page_size=10&query=laos").
    with(
      headers: {
    'Accept'=>'*/*',
    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: learning_image_laos, headers: {})     

    get "/api/v1/learning_resources?country=laos", headers: {"CONTENT_TYPE" => "application/json", "Accept": "application/json"}
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(json_response[:data]).to be_a(Hash)
    expect(json_response[:data]).to be_a(Hash)
    expect(json_response[:data][:id]).to eq(nil)
    expect(json_response[:data][:type]).to eq("learning_resource")
    expect(json_response[:data][:attributes]).to be_a(Hash)
    expect(json_response[:data][:attributes][:video]).to eq({:youtube_video_id=>"uw8hjVqxMXw", :title=>"A Super Quick History of Laos"})
    expect(json_response[:data][:attributes][:images].first[:alt_tag]).to eq("time lapse photography of flying hot air balloon")
    expect(json_response[:data][:attributes][:images].first[:url]).to eq("https://images.unsplash.com/photo-1540611025311-01df3cef54b5?crop=entropy&cs=srgb&fm=jpg&ixid=M3w1NzQzNjV8MHwxfHNlYXJjaHwxfHxsYW9zfGVufDB8fHx8MTcwOTQyNzIyOHww&ixlib=rb-4.0.3&q=85")
    expect(json_response[:data][:attributes][:images].count).to eq(10)
    expect(json_response[:data][:attributes][:country]).to eq("laos")
  end

  it "has no response from images or videos" do
    no_learning_video_laos = File.read("spec/fixtures/no_data_videos.json")
    stub_request(:get, "https://youtube.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{Rails.application.credentials.YOUTUBE[:KEY]}&maxResults=1&part=snippet&q=nameofcountry").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: no_learning_video_laos, headers: {})

    no_learning_image_laos = File.read("spec/fixtures/no_data_images.json")
    stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{Rails.application.credentials.UNSPLASH[:ACCESS_KEY]}&page=1&page_size=10&query=nameofcountry").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: no_learning_image_laos, headers: {})     

    get "/api/v1/learning_resources?country=nameofcountry", headers: {"CONTENT_TYPE" => "application/json", "Accept": "application/json"}
    
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(json_response[:data]).to be_a(Hash)
    expect(json_response[:data][:id]).to eq(nil)
    expect(json_response[:data][:type]).to eq("learning_resource")
    expect(json_response[:data][:attributes]).to be_a(Hash)
    expect(json_response[:data][:attributes][:video]).to eq({})
    expect(json_response[:data][:attributes][:images]).to eq([])
    expect(json_response[:data][:attributes][:country]).to eq("nameofcountry")
  end
end