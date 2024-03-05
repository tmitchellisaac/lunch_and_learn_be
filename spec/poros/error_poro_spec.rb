require 'rails_helper'

describe "Error PORO" do
  it "create and error poro correctly" do
    poro = Error.new("incorrect API key", 401)
    expect(poro).to be_an(Error)
    expect(poro.message).to eq("incorrect API key")
    expect(poro.status_code).to eq(401)
  end
end