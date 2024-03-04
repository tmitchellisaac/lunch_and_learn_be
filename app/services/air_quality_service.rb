class AirQualityService

  def conn
    Faraday.new(url: "http://api.openweathermap.org/data/2.5/air_pollution") do |faraday|
    faraday.params["appid"] = Rails.application.credentials.OPEN_WEATHER[:KEY]
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_air_quality(latlng)
    get_url("?lat=#{latlng[0]}&lon=#{latlng[1]}")[:list].first
  end

  # def get_learning_image(country)
  #   get_url("?query=#{country}")[:results]
  # end


end