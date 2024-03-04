class Api::V1::AirQualityController < ApplicationController

  def index
    # facade = AirQualityFacade.new(params[:country]).big_air_quality
    render json: AirQualitySerializer.new(AirQualityFacade.new(params[:country]).big_air_quality)
    # not really sure if the one line is better than splitting it up? for readability
  end


end