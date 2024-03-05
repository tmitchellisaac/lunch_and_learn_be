require 'rails_helper'

describe "Error Serializer" do
  it "serializes an Error PORO" do
    poro = Error.new("incorrect API key", 401)
    serializer = ErrorSerializer.new(poro)
    serializer.serialize_json
    expect(serializer).to be_a(ErrorSerializer)
    expect(serializer.error).to be_a(Error)
    expect(serializer.error.message).to eq("incorrect API key")
    expect(serializer.error.status_code).to eq(401)

  end
end