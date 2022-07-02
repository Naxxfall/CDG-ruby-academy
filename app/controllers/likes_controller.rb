class LikesController < ApplicationController

  def create
    @post = Post.find(post_params)
    @like = @post.likes.build
    @like.user = current_user
    redirect_to post_path(@post) if @like.save
  end

  def destroy
    @like = Like.find(like_params)
    redirect_to post_path(@like.post) if @like.destroy
  end

  private

  def post_params
    params.require(:post_id)
  end

  def like_params
    params.require(:like_id)
  end
  
end
