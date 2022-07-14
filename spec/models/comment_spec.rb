require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { build(:comment) }

  it "is valid" do
    is_expected.to be_valid
  end

  it { should validate_presence_of(:text) }

  it { should belong_to(:user) }

  it { should belong_to(:post) }

end