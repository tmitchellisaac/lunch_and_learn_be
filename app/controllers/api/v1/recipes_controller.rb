class Api::V1::RecipesController < ApplicationController

  def index
    facade = RecipeFacade.new(params)
    render json: RecipeSerializer.new(facade.recipes).serializable_hash.to_json
  end


end