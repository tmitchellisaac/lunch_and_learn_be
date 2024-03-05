class Api::V1::FavoritesController < ApplicationController

  def index
    user = User.find_by(api_key: params[:api_key])
      if user
        render json: FavoriteSerializer.new(favorites = user.favorites)
      else
        render json: ErrorSerializer.new(Error.new("incorrect API key", 401)), status: 401
      end
  end


  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      favorite = Favorite.create!(strong_params.merge(user_id: user.id))
      if favorite.save
        render json: {
          success: "Favorite added successfully"
        }, status: 201
      else
      render json: ErrorSerializer.new(Error.new("something went wrong", 400))
      end
    else
      render json: ErrorSerializer.new(Error.new("incorrect API key", 401)), status: 401
    end
  end

  def destroy
    user = User.find_by(api_key: params[:api_key])
    if user
     favorite = Favorite.find(params[:favorite_id])
     if favorite.destroy
      render json: {
        success: "Favorite successfully deleted"
      }, status: 200
      # require 'pry'; binding.pry
     else
      render json: ErrorSerializer.new(Error.new("something went wrong", 400)), status: 400
     end
    else
      render json: ErrorSerializer.new(Error.new("incorrect API key", 401)), status: 401
    end
  end

  private

  def strong_params
    params.permit(:recipe_title, :recipe_link, :country)
  end


end