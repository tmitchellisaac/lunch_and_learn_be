class Api::V1::LearningResourcesController < ApplicationController

  def index
    facade = LearningFacade.new(params)
    render json: LearningResourceSerializer.new(facade.learning).serializable_hash.to_json
  end

end