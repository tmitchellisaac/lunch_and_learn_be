class LearningResource  
  attr_reader :country,
              :id,
              :images,
              :video

  def initialize(json_data)
    @id = nil
    @country = json_data[2]
    @images = json_data[1]
    @video = json_data[0]
  end

  # def video #have this so the serilizer stuff will work as a hash
  #   @video_data
  # end

  # def images #have this so the serilizer stuff will work as a hash
  #   @image_data
  # end
end