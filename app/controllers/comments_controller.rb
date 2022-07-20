class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.create(comment_params)
    @comment.user = current_user
    redirect_to @comment.post if @comment.save
  end

  def update
    @comment = current_user.comments.find(params[:comment_id])
    redirect_to @comment.post if @comment.update(text: params[:text])
  end

  def destroy
    @comment = current_user.comments.find(params[:comment_id])
    redirect_to post_path(@comment.post), status: 303 if @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :post_id)
  end
  
end
