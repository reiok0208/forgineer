class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.save!
    @comments = Comment.where(diary_id: @comment.diary_id)
  end

  def destroy
    @comment = Comment.find(params[:id])
    diary = @comment.diary_id
    @comment.destroy
    @comments = Comment.where(diary_id: diary)
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :diary_id, :title, :body)
  end

end
