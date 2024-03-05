require 'rails_helper'

describe "Learning Video Service" do
  it "gets a video based on a country --> #get_learning_video" do
    laos_videos = File.read("spec/fixtures/learning_laos_video.json")
    stub_request(:get, "https://youtube.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{Rails.application.credentials.YOUTUBE[:KEY]}&maxResults=1&part=snippet&q=Laos").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: laos_videos, headers: {})

    learning_video_service = LearningVideoService.new
    result = learning_video_service.get_learning_video("Laos")

    expect(result.count).to eq(6)
    expect(result[:items].first[:snippet][:title]).to eq("A Super Quick History of Laos")
    expect(result[:items].first[:snippet][:channelId]).to eq("UCluQ5yInbeAkkeCndNnUhpw")
    expect(result[:items].first[:id][:videoId]).to eq("uw8hjVqxMXw")
  end
end