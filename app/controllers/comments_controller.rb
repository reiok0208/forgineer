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
    @user = User.find(@comment.user_id)
    unless @user.admin? #管理者以外はbodyをサニタイズしたものになる。script対策
      body_sanitize = Sanitize.clean(@comment.body, Sanitize::Config::BASIC)
      @comment.assign_attributes(body: body_sanitize)
    end
    @comment.save
    @comments = Comment.where(diary_id: @comment.diary_id) #最後に日記に紐付いたコメントを全取得し非同期に対応
  end

  def update
    @comment = Comment.find(params[:id])
    unless current_user.admin? #管理者以外の場合
      @comment.assign_attributes(comment_params)
      @comment.body.gsub!(/<|>/, "<" => "&lt;", ">" => "&gt;")
      @comment.update_attributes(body: Sanitize.clean(@comment.body, Sanitize::Config::BASIC))
    else
      @comment.update(comment_params)
    end

    if @comment.valid? #上記の分岐処理が有効かどうか
      flash[:notice] = 'コメントを更新しました'
      redirect_to diary_path(params[:diary_id])
    else
      flash[:notice] = 'コメントを更新できませんでした。タイトルは1文字以上30文字以内です。'
      redirect_to diary_path(params[:diary_id])
    end
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
