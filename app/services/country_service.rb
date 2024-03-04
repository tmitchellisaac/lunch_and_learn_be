class CountryService 

  def conn
    Faraday.new(url: "https://restcountries.com/v3.1") do |faraday|
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_country
    result = get_url("all?fields=name")
  end

  def get_coordinates(country)
    get_url("name/#{country}?fullText=true&fields=name,latlng").first[:latlng]
  end

end