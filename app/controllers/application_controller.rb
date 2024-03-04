class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :param_missing
  rescue_from ActiveRecord::RecordInvalid, with: :uniq_email

  # def param_missing
  #   render json: ErrorSerializer.new(Error.new(exception.message))
  #       .serialize_json, status: 400
  # end

  def uniq_email
    render json: ErrorSerializer.new(Error.new("email is not unique", 400)), status: 400
   end
end
