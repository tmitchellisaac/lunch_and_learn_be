class LearningVideoService

  def conn
    Faraday.new(url: "https://youtube.googleapis.com/youtube/v3/search") do |faraday|
    faraday.params["key"] = Rails.application.credentials.YOUTUBE[:KEY]
    faraday.params["channelId"] = "UCluQ5yInbeAkkeCndNnUhpw" #Mr. History account
    faraday.params["part"] = "snippet"
    faraday.params["maxResults"] = "1"
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_learning_video(country)
    get_url("?q=#{country}")
  end

end