require 'rails_helper'

describe "Learning Resource Poro" do
  it "creates a LearningResource poro with correct data" do
    learning_video = {:youtube_video_id=>"uw8hjVqxMXw", :title=>"A Super Quick History of Laos"}
    learning_images = [{:alt_tag=>"time lapse photography of flying hot air balloon",
      :url=>"https://images.unsplash.com/photo-1540611025311-01df3cef54b5?crop=entropy&cs=srgb&fm=jpg&ixid=M3w1NzQzNjV8MHwxfHNlYXJjaHwxfHxsYW9zfGVufDB8fHx8MTcwOTQyNzIyOHww&ixlib=rb-4.0.3&q=85"},
      {:alt_tag=>"aerial view of city at daytime",
      :url=>"https://images.unsplash.com/photo-1570366583862-f91883984fde?crop=entropy&cs=srgb&fm=jpg&ixid=M3w1NzQzNjV8MHwxfHNlYXJjaHwyfHxsYW9zfGVufDB8fHx8MTcwOTQyNzIyOHww&ixlib=rb-4.0.3&q=85"}]
    country = "Laos"

    poro_input = [learning_video, learning_images, country]
    poro = LearningResource.new(poro_input)
    
    expect(poro).to be_a(LearningResource)
    expect(poro.country).to eq("Laos")
    expect(poro.images).to eq([{:alt_tag=>"time lapse photography of flying hot air balloon",
      :url=>"https://images.unsplash.com/photo-1540611025311-01df3cef54b5?crop=entropy&cs=srgb&fm=jpg&ixid=M3w1NzQzNjV8MHwxfHNlYXJjaHwxfHxsYW9zfGVufDB8fHx8MTcwOTQyNzIyOHww&ixlib=rb-4.0.3&q=85"},
      {:alt_tag=>"aerial view of city at daytime",
      :url=>"https://images.unsplash.com/photo-1570366583862-f91883984fde?crop=entropy&cs=srgb&fm=jpg&ixid=M3w1NzQzNjV8MHwxfHNlYXJjaHwyfHxsYW9zfGVufDB8fHx8MTcwOTQyNzIyOHww&ixlib=rb-4.0.3&q=85"
      }])
    expect(poro.video).to eq({:youtube_video_id=>"uw8hjVqxMXw", :title=>"A Super Quick History of Laos"})
  end
end