require 'rspec'
require './foobar.rb'

RSpec.describe "Checking foobar result" do
  it "First number is 20" do
    n1 = 20
    n2 = 5
    expect(foobar(n1, n2)).to eq(n2)
  end
  it "Second number is 20" do
    n1 = 5
    n2 = 20
    expect(foobar(n1, n2)).to eq(n2)
  end
  it "Both numbers are 20" do
    n1 = 20
    n2 = 20
    expect(foobar(n1, n2)).to eq(n2)
  end
  it "Numbers not equal to 20" do
    n1 = 21
    n2 = 4
    expect(foobar(n1, n2)).to eq(n1 + n2)
  end
end