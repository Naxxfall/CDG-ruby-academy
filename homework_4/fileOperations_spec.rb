require 'rspec'
require '../homework_4/fileOperations.rb'

TEST_FILE_PATH = "test.txt"

RSpec.describe 'Actors Management' do
  let(:string) do
    <<-STRING
Matthew McConaughey
Ryan Gosling
Sylvester Stallone
Leonardo DiCaprio
    STRING
  end

  before { File.write(TEST_FILE_PATH, string) }

  it "#index" do
    expect{ index(TEST_FILE_PATH) }.to output(string).to_stdout
  end

  it "#find" do
    expect{ find(TEST_FILE_PATH, 1)}.to output("Ryan Gosling\n").to_stdout
  end

  it "#where" do
    expect{ where(TEST_FILE_PATH, "Gosling")}.to output("Ryan Gosling\n").to_stdout
  end

  it "#update" do
    update(TEST_FILE_PATH, 2, "Rami Malek")
    expect{ find(TEST_FILE_PATH, 2)}.to output("Rami Malek\n").to_stdout
  end

  it "#delete" do
    delete(TEST_FILE_PATH, 2)
    expect{ find(TEST_FILE_PATH, 2)}.to output("Leonardo DiCaprio\n").to_stdout
  end                                                                 

  after { File.delete(TEST_FILE_PATH) }

end                

