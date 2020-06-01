class CommentsController < ApplicationController

  def create
    @diary = Diary.find(params[:diary_id])
    if user_signed_in?
      @comment = current_user.comments.new(comment_params)
    else
      #非会員には非会員専用のuser_id2を付与
      @comment = Comment.new(comment_params)
      @comment.user_id = 2
    end
    @comment.diary_id = @diary.id
    @comment.save
    @comments = Comment.where(diary_id: @comment.diary_id)
  end

  def destroy
    if user_signed_in?
      @comment = Comment.find(params[:id])
      diary = @comment.diary_id
      @comment.destroy
      @comments = Comment.where(diary_id: diary)
    else
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :body)
  end

end
