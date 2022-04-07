require 'rspec'
require '../homework_3/stringProcessing.rb'

RSpec.describe "Checking stringProcessing result" do
  it "string ends with CS" do
    word = "BrooCS"
    expect(stringProcessing(word)).to eq(2**6)
  end
  it "string does not end with CS" do
    word = "testString"
    expect(stringProcessing(word)).to eq("gnirtStset")
  end
end