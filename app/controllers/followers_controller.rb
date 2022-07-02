class FollowersController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @follow = Follower.new
    @follow.followed = @user
    @follow.follower = current_user
    redirect_to @user if @follow.save
  end

  def destroy
    @user = Follower.find(params[:id]).followed
    current_user.unfollow(@user)
    redirect_to @user
  end

end
