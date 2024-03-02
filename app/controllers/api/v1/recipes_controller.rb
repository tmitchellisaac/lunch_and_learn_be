class Api::V1::RecipesController < ApplicationController

  def index
      facade = RecipeFacade.new(params).recipes
      render json: RecipeSerializer.new(facade).serializable_hash.to_json
  end


end