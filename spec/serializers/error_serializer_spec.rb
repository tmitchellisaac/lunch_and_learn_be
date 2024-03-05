require 'rails_helper'

describe "Error Serializer" do
  it "serializes an Error PORO" do
    poro = Error.new("incorrect API key", 401)
    serializer = ErrorSerializer.new(poro)
    expect(serializer).to be_a(ErrorSerializer)
  end
end