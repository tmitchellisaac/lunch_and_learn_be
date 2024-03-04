class Api::V1::AirQualityController < ApplicationController

  def index
    facade = AirQualityFacade.new(params).big_air_quality
    render json: AirQualitySerializer.new(facade)
  end


end