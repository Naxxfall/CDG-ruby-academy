require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it "is valid" do
    is_expected.to be_valid
  end

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:email) }

  it { should validate_uniqueness_of(:name) }

  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }

  it { should have_many(:posts).dependent(:destroy) }

  it { should have_many(:comments).dependent(:destroy) }

  it { should have_many(:likes).dependent(:destroy) }

end