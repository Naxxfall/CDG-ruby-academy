require 'rspec'
require '../homework_3/pokemons.rb'

RSpec.describe "Checking pokemon creating" do
  it "Pokemon with name Slow and color Pink" do
    slowPoke = {:name => "Slow", :color =>"Pink"}
    expect(pokemonCreate("Slow", "Pink")).to eq(slowPoke)
  end
end