class LearningImageService

  def conn
    Faraday.new(url: "https://api.unsplash.com/search/photos") do |faraday|
    faraday.params["client_id"] = Rails.application.credentials.UNSPLASH[:ACCESS_KEY]
    faraday.params["page"] = "1"
    faraday.params["page_size"] = "10"
    
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_learning_image(country)
    get_url("?query=#{country}")[:results]
  end


end