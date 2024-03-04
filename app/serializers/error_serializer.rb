class ErrorSerializer
  def initialize(error_object)
    @error = error_object
  end

  def serialize_json
    {
      errors: [
        {
          status: @error.status_code.to_s,
          title: @error.message
        }
      ]
    }
  end
end