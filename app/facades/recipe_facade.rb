class RecipeFacade

  def initialize(params)
    @params = params
    @country = params[:country]
  end

  def recipes
    service = RecipeService.new
    if @country && @country != ""
      service.get_recipes(@country).map do |recipe|
        Recipe.new(recipe, @country)
      end
    else
      country_name_array = []
      CountryService.new.get_country.map do |country_data|
        country_name_array << country_data[:name][:common]
      end
      rando_country = country_name_array.sample
      service.get_recipes(rando_country).map do |recipe|
        Recipe.new(recipe, rando_country)
      end
    end
  end
end