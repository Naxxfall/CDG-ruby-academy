require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { build(:post) }

  it "is valid" do
    is_expected.to be_valid
  end

  it { should belong_to(:user) }

  it { should validate_presence_of(:image_data) }

  it { should validate_presence_of(:caption) }

end