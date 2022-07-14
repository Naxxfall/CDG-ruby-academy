require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create :user }

  describe "#index" do
    subject { process :index }

    let(:posts) { create_list(:post, 5) }

    it "renders the index template" do
      subject
      expect(response).to render_template :index
    end

    it 'assigns @posts' do
      subject
      expect(assigns(:posts)).to eq posts
    end
  end

  describe "#show" do
    subject { process :show, params: params }
    let(:post) { create :post }
    let(:params) { { id: post.id }}

    it "renders the post template" do
      subject
      expect(response).to render_template :show
    end

    it 'assigns @post' do
      subject
      expect(assigns(:post)).to eq post
    end
  end

  describe "#new" do
    before { sign_in user }
    subject { process :new }

    it "assigns @post" do
      subject
      expect(assigns(:post)).to be_a_new Post
    end

    it "renders te new template" do
      subject
      expect(response).to render_template :new
    end

  end

  describe "#create" do
    before { sign_in user }
    subject { process :create, method: :post, params: params }
    let(:params) { { post: attributes_for(:post, user: user ) } }

    it "creates a post" do
      expect{ subject }.to change(Post, :count).by(1)
    end

    it "redirects to post page" do
      subject
      expect(response).to redirect_to Post.last
    end

    it "assigns post to current user" do
      subject
      expect(assigns(:post).user).to eq user
    end
  end

  describe "#edit" do
    before { sign_in user }
    subject { process :edit, params: params }
    let(:post) { create :post, user: user }
    let(:params) { { id: post.id }}

    it "renders the edit template" do
      subject
      expect(response).to render_template :edit
    end

    it 'assigns @post' do
      subject
      expect(assigns(:post)).to eq post
    end
  end

  describe "#update" do
    before { sign_in user }
    subject { process :update, method: :post, params: params }
    let(:post) { create :post, user: user }
    let(:params) { { post: attributes_for(:post) } }

    it "redirects to post page" do
      subject
      expect(response).to redirect_to post_path(post)
    end
  end

  describe "#destroy" do
    before { sign_in user }
    subject { process :destroy, method: :delete, params: params }
    let!(:post) { create :post, user: user }
    let(:params) { { id: post.id }}

    it "deletes the post" do
      expect { subject }.to change(user.posts, :count).by(-1)
    end

    it "redirects to posts index" do
      subject
      expect(response).to redirect_to posts_path
    end

    context "when user tries to remove someone's post" do
      let(:post) { create :post }

      it "does not delete the post" do
        expect { subject }.to change(user.posts, :count).by(0)
      end

      it "raises exception" do
        expect { subject }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

  end


end