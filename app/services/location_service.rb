class LocationService

  
  def conn
    Faraday.new(url: "http://api.openweathermap.org/geo/1.0/direct") do |faraday|
    faraday.params["appid"] = Rails.application.credentials.OPEN_WEATHER[:KEY]
    end
  end

  def get_url(url)
    response = conn.get(url)
    require 'pry'; binding.pry
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_coordinates(location)
    get_url("?q=#{location}&limit=1")
  end


end