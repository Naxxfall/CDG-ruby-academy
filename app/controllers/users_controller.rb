class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.includes(:posts).find(params[:id])
    @user_posts = @user.posts
  end

  private

end
