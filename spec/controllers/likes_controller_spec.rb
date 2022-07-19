require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let!(:user) { create :user }
  let!(:post) { create :post }
  before { sign_in user }

  describe "#create" do
    subject { process :create, method: :post, params: params }

    let(:params) {{ post_id: post.id }}

    it "likes post" do
      expect{ subject }.to change(post.likes, :count).by(1)
    end

    it "assigns like to current user" do
      subject
      expect(assigns(:like).user).to eq user
    end

    it "assigns like to current post" do
      subject
      expect(assigns(:like).post).to eq post
    end

    context "when user is not authenticated" do
      before {sign_out user}

      it "tries to like post" do
        subject
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when user tries to like post twice" do
      subject! { process :create, method: :post, params: params }

      it "tries to like post" do
        expect { subject }.to change(post.likes, :count).by(0)
      end
    end
  end

  describe "#destroy" do
    subject { process :destroy, method: :delete, params: params }
    #subject { delete "/likes/#{like.id}", method: :delete }
    #subject { delete :destroy, method: :delete, params: params }

    let!(:like) { create :like, user: user, post: post }
    let(:params) { { like_id: like.id } }

    it "unlikes post" do
      expect{ subject }.to change(post.likes, :count).by(-1)
    end

    context "when user is not authenticated" do
      before {sign_out user}

      it "tries to unlike post" do
        subject
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when user tries to remove other's like" do
      let(:other_user) { create :user }
      before { sign_in other_user }

      it "tries to unlike post" do
        expect { subject }.to change(post.likes, :count).by(0)
      end
    end
  end
end