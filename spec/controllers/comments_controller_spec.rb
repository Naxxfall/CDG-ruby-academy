require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:user) { create :user }
  let!(:post) { create :post, user: user }
  before { sign_in user }

  describe "#create" do
    subject { process :create, method: :post, params: params }

    let!(:params) {{ comment: attributes_for(:comment, user: user, post: post).merge(:post_id => post.id) }}

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

    context "when user is not authenticated" do
      before {sign_out user}

      it "tries to create comment" do
        subject
        expect(response).to redirect_to new_user_session_path
      end
    end

  end

  describe "#update" do
    subject { process :update, method: :patch, params: params}
    let!(:comment) { create :comment, user: user, post: post }
    let(:params) {{ comment_id: comment.id, text: comment.text }}

    it "redirects to post page" do
      subject
      expect(response).to redirect_to comment.post
    end

    context "when user is not authenticated" do
      before {sign_out user}

      it "tries to update comment" do
        subject
        expect(response).to redirect_to new_user_session_path
      end
    end

  end

  describe "#destroy" do
    before { sign_in user }
    subject { process :destroy, method: :delete, params: params }
    let!(:comment) { create :comment, user: user, post: post }
    let(:params) {{ comment_id: comment.id }}

    it "deletes the comment" do
      expect { subject }.to change(post.comments, :count).by(-1)
    end

    it "redirects to post" do
      subject
      expect(response).to redirect_to post
    end

    context "when user is not authenticated" do
      before {sign_out user }

      it "tries to delete comment" do
        subject
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when other user tries to delete comment" do
      before { sign_in other_user }
      let!(:other_user) { create :user }

      it "tries to delete comment" do
        expect{ subject }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end