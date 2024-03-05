class LearningFacade

  def initialize(params)
    @country = params[:country]
  end

  def video_service
    LearningVideoService.new
  end

  def image_service
    LearningImageService.new
  end

  def learning
    LearningResource.new([learning_video,learning_images, @country])
  end

  def learning_images
    image_array = []
    image_service.get_learning_images(@country).map do |image_data|
      hash = {}
      hash[:alt_tag] = image_data[:alt_description]
      hash[:url] = image_data[:urls][:full]
      image_array << hash
    end
    image_array
  end

  def learning_video
    video_hash= {}
    r = video_service.get_learning_video(@country)[:items].first
    if r
      video_hash[:youtube_video_id] = r[:id][:videoId]
      video_hash[:title] = r[:snippet][:title]
      video_hash
    else
      {}
    end
  end
  
end