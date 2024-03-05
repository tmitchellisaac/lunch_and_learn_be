require 'rails_helper'

describe "Learning Resource Facade" do
  before(:each) do
    @learning_resource_facade = LearningFacade.new(country: "Laos")
    @learning_resource_facade_2 = LearningFacade.new(country: "ghghghghgkdkd")
  end

  it "has a method that combines #learning_image, #learning_video, and country into a LearingResource PORO --> #learning" do
    laos_images = File.read("spec/fixtures/laos_images.json")
    stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{Rails.application.credentials.UNSPLASH[:ACCESS_KEY]}&page=1&page_size=10&query=Laos").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: laos_images, headers: {})  
    
    laos_video = File.read("spec/fixtures/learning_laos_video.json")
    stub_request(:get, "https://youtube.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{Rails.application.credentials.YOUTUBE[:KEY]}&maxResults=1&part=snippet&q=Laos").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: laos_video, headers: {})

    result = @learning_resource_facade.learning
    expect(result).to be_a(LearningResource)
    expect(result.id).to eq(nil)
    expect(result.country).to eq("Laos")
    expect(result.images.count).to eq(10)
    expect(result.images.first[:alt_tag]).to eq("time lapse photography of flying hot air balloon")
    expect(result.images.first[:url]).to eq("https://images.unsplash.com/photo-1540611025311-01df3cef54b5?crop=entropy&cs=srgb&fm=jpg&ixid=M3w1NzQzNjV8MHwxfHNlYXJjaHwxfHxsYW9zfGVufDB8fHx8MTcwOTQyNzIyOHww&ixlib=rb-4.0.3&q=85")
    expect(result.images.count).to eq(10)
    expect(result.video).to eq({:youtube_video_id=>"uw8hjVqxMXw", :title=>"A Super Quick History of Laos"})
  end

  it "[SAD] doesn't break if country doesn't exist --> #learning" do
    no_video_returned = File.read("spec/fixtures/no_data_videos.json")
    stub_request(:get, "https://youtube.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{Rails.application.credentials.YOUTUBE[:KEY]}&maxResults=1&part=snippet&q=ghghghghgkdkd").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: no_video_returned, headers: {})

    no_images = File.read("spec/fixtures/no_data_images.json")
    stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{Rails.application.credentials.UNSPLASH[:ACCESS_KEY]}&page=1&page_size=10&query=ghghghghgkdkd").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: no_images, headers: {})

    result = @learning_resource_facade_2.learning
    expect(result).to be_a(LearningResource)
    expect(result.id).to eq(nil)
    expect(result.country).to eq("ghghghghgkdkd")
    expect(result.images).to eq([])
    expect(result.video).to eq({})
  end

  it "gets images based on country --> #learning_image" do
    laos_images = File.read("spec/fixtures/laos_images.json")
    stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{Rails.application.credentials.UNSPLASH[:ACCESS_KEY]}&page=1&page_size=10&query=Laos").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'User-Agent'=>'Faraday v2.9.0'
      }).
    to_return(status: 200, body: laos_images, headers: {})

    result = @learning_resource_facade.learning_images

    expect(result.count).to eq(10)
    expect(result.first[:alt_tag]).to eq("time lapse photography of flying hot air balloon")
    expect(result.first[:url]).to eq("https://images.unsplash.com/photo-1540611025311-01df3cef54b5?crop=entropy&cs=srgb&fm=jpg&ixid=M3w1NzQzNjV8MHwxfHNlYXJjaHwxfHxsYW9zfGVufDB8fHx8MTcwOTQyNzIyOHww&ixlib=rb-4.0.3&q=85")
  end

  it "[SAD] returns an empty array if no images are found for the country --> #learning_images" do
    no_images = File.read("spec/fixtures/no_data_images.json")
    stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{Rails.application.credentials.UNSPLASH[:ACCESS_KEY]}&page=1&page_size=10&query=ghghghghgkdkd").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: no_images, headers: {})

    result = @learning_resource_facade_2.learning_images
    expect(result).to eq([])
  end

  it "get a video based on a country --> #learning_video" do
    laos_video = File.read("spec/fixtures/learning_laos_video.json")
    stub_request(:get, "https://youtube.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{Rails.application.credentials.YOUTUBE[:KEY]}&maxResults=1&part=snippet&q=Laos").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: laos_video, headers: {})

    result = @learning_resource_facade.learning_video
    expect(result).to eq({:youtube_video_id=>"uw8hjVqxMXw", :title=>"A Super Quick History of Laos"})
  end

  it "[SAD] returns empty hash if video for country is not found --> #learning_video" do
    no_video_returned = File.read("spec/fixtures/no_data_videos.json")
    stub_request(:get, "https://youtube.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{Rails.application.credentials.YOUTUBE[:KEY]}&maxResults=1&part=snippet&q=ghghghghgkdkd").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: no_video_returned, headers: {})

    result = @learning_resource_facade_2.learning_video
    expect(result).to eq({})
  end

  it "has a video service creation method --> #video_service" do
    expect(@learning_resource_facade.video_service).to be_a(LearningVideoService)
  end

  it "has an image service creation method --> #image_service" do
    expect(@learning_resource_facade.image_service).to be_a(LearningImageService)
  end

end