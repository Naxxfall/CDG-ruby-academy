require 'rails_helper'

RSpec.describe Follower, type: :model do
  subject { build(:follower) }

  it "is valid" do
    is_expected.to be_valid
  end

  it { should belong_to(:follower).through(:users) }

  it { should belong_to(:followed).through(:users) }

end