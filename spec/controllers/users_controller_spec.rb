require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:users) { create_list(:user, 5) }

  describe "#index" do
    subject { process :index }

    it "renders the index template" do
      subject
      expect(response).to render_template :index
    end

    it 'assigns @users' do
      subject
      expect(assigns(:users)).to eq users
    end
  end

  describe "#show" do
    subject { process :show, params: params }
    let!(:user) { users.first }
    let(:params) { { id: user.id }}
    let!(:user_posts) { create_list(:post, 5, user: user) }

    it "renders the user template" do
      subject
      expect(response).to render_template :show
    end

    it 'assigns @user' do
      subject
      expect(assigns(:user)).to eq user
    end

    it 'assigns @user_posts' do
      subject
      expect(assigns(:user_posts)).to eq user_posts
    end
  end

end