class Api::V1::UsersController < ApplicationController

  def create
    if params[:password] == params[:password_confirmation]
      uniq_key = SecureRandom.base64
      user = User.create!(user_params.merge(
        api_key: uniq_key)
      )
      if user.save
        render json: UserSerializer.new(user)
      else
        render json: ErrorSerializer.new(Error.new("invalid credentials, please try again", 400))
      end
    elsif params[:password] != params[:password_confirmation]
      render json: ErrorSerializer.new(Error.new("invalid credentials, please try again", 400)), status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :name, :password_digest, :password, :password_confirmation)
  end

end