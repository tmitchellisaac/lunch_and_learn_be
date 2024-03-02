class RecipeFacade

  def initialize(params)
    @params = params
    @country = params[:country]
  end



  def recipes
    service = RecipeService.new
    r = service.get_recipes(@country)
    x = r.map do |recipe|
      Recipe.new(recipe, @country)
    end
  end
end