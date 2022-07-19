require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let!(:post) { create :post }
  let(:user) { create :user }
  let!(:comments) { create_list(:comment, 5, post: post, user: user) }

  describe "displays comments for post" do
    subject{ get post_path(post)}

    it "returns comments" do
    subject
    expect(response.body).to include post.comments.last.text
    end

  end
end