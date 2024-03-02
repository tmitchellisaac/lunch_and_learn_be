class RecipeService

  def conn
    Faraday.new(url: "https://api.edamam.com/api/recipes/v2") do |faraday|
    faraday.params["app_key"] = Rails.application.credentials.EDAMAM[:EDAMAM_KEY]
    faraday.params["app_id"] = Rails.application.credentials.EDAMAM[:EDAMAM_ID]
    faraday.params["type"] = "public"
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_recipes(country)
    get_url("?q=#{country}")[:hits]
  end

  # def top_rated_movies
  #   get_url("3/movie/top_rated")[:results]
  # end


end