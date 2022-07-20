require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:user) { create :user }
  let!(:post) { create :post }
  before { sign_in user }

  describe "#create" do
    subject { process :create, method: :post, params: params }

    let(:params) {{ comment: attributes_for(:comment, user: user, post: post) }}

    it "creates a comment" do
      expect{ subject }.to change(user.comments, :count).by(1)
    end

    it "assigns comment to current user" do
      subject
      expect(assigns(:comment).user).to eq user
    end

    it "assigns comment to current post" do
      subject
      expect(assigns(:comment).post).to eq post
    end
  end

end