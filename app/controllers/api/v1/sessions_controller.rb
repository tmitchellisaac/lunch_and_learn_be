class Api::V1::SessionsController < ApplicationController

  def login 
    if user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        render json: UserSerializer.new(user)
      else
        render json: ErrorSerializer.new(Error.new("invalid credentials, please try again", 400)), status: 400
      end
    else 
      render json: ErrorSerializer.new(Error.new("invalid credentials, please try again", 400)), status: 400
    end
  end
end