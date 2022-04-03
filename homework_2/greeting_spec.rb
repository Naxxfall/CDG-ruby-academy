require 'rspec'
require './greeting.rb'

name = "Serj"
sname = "Fedorchenko"
RSpec.describe "Checking greeting" do
  it "age < 18" do
    expect(greeting(name, sname, 17)).to eq("Привет, #{name} #{sname}! Тебе меньше 18 лет, но начать учиться программировать никогда не рано!")
  end
  it "age >= 18" do
    expect(greeting(name, sname, 19)).to eq("Привет, #{name} #{sname}! Самое время заняться делом!")
  end
end