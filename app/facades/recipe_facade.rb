class RecipeFacade

  def initialize(params)
    @params = params
    @country = params[:country]
  end

  def service
    RecipeService.new
  end

  def recipes
    @country && @country != "" ? recipes_small(@country) : recipes_small(random_country)
  end

  def recipes_small(country)
    service.get_recipes(country).map do |recipe|
      Recipe.new(recipe, country)
    end
  end

  def random_country
    country_name_array = []
      CountryService.new.get_country.map do |country_data|
        country_name_array << country_data[:name][:common]
      end
    country_name_array.sample
  end

end