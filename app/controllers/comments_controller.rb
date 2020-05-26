class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save!
      redirect_to diary_path(@comment.diary_id)
    else
      redirect_to diary_path(@comment.diary_id)
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      redirect_to diary_path(comment.diary_id)
    else
      redirect_to diary_path(comment.diary_id)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :diary_id, :title, :body)
  end

end
