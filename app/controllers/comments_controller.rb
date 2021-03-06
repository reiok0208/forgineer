class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  def create
    @diary = Diary.find(params[:diary_id])
    if user_signed_in?
      @comment = current_user.comments.new(comment_params)
    else
      # 非会員にはuser_idをnilで渡す
      @comment = Comment.new(comment_params)
      @comment.user_id = nil
    end
    @comment.diary_id = @diary.id
    @user = User.find_by(id: @comment.user_id)
    if @user.nil? || !@user.admin? # 管理者以外はbodyをサニタイズしたものになる。script対策
      @comment.assign_attributes(body: ERB::Util.html_escape(@comment.body))
    end
    @comment.save
    @comments = Comment.where(diary_id: @comment.diary_id) # 最後に日記に紐付いたコメントを全取得し非同期に対応
  end

  def edit
    @diary = Diary.find(params[:diary_id])
    @comment = Comment.find(params[:id])
    if current_user.id != @comment.user_id
      redirect_to root_path
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if current_user.admin?
      @comment.update(comment_params)
    else # 管理者以外の場合
      @comment.assign_attributes(comment_params)
      @comment.update_attributes(body: ERB::Util.html_escape(@comment.body))
    end

    if @comment.valid? # 上記の分岐処理が有効かどうか
      flash[:notice] = 'コメントを更新しました'
      redirect_to diary_path(params[:diary_id])
    else
      flash[:notice] = 'コメントを更新できませんでした。タイトルは1文字以上30文字以内です。'
      redirect_to edit_diary_comment_path(diary_id: params[:diary_id], id: @comment.id)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    diary = @comment.diary_id
    if current_user.id == @comment.user_id || current_user.admin?
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
