class DiariesController < ApplicationController
  include DiariesHelper
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit, :update]
  impressionist :actions=>[:show]

  def new
    if current_user.id == params[:user_id].to_i #カレント以外は遷移できない
      @diary = Diary.new
      @tag = Tag.new
    else
      redirect_to root_path
    end
  end

  def index
    #Tagとdiary_tagsをテーブル結合し、diary_tagsのtag_idを基準とし、diary_id数をカウント、数がが大きい順に変数に渡す。
    @tags = Tag.joins(:diary_tags).group(:tag_id).order(Arel.sql('count(diary_id) desc')).limit(10)
    @most_viewed = Diary.order('impressions_count DESC').take(10)
    if params["user_id"].nil?
      #indexアクションにtag_idがパラメーターで送られたときにそのtag_idに紐付いた日記を@diariesに渡す。
      diaries = params[:tag_id].present? ? Tag.search(params[:tag_id]) : Diary.search(params[:search])
      option(diaries) #インスタンス変数を渡すヘルパー
    else
      #indexアクションにuser_idがパラメーターで送られたときにそのuser_idに紐付いた日記を@diariesに渡す。
      diaries = Diary.where(user_id: params["user_id"])
      option(diaries)
    end
  end

  def show
    if params[:diary_id].nil? #日記詳細の通常表示の場合
      @diary = Diary.find(params[:id])
      @comments = Comment.where(diary_id: params[:id])
      @comment = Comment.new
    end
  end

  def create
    if current_user.id == params[:user_id].to_i
      @diary = Diary.new(diary_params)
      unless current_user.admin? #管理者以外はbodyをサニタイズしたものになる。script対策
        @diary.body.gsub!(/<|>/, "<" => "&lt;", ">" => "&gt;")
        body_sanitize = Sanitize.clean(@diary.body, Sanitize::Config::BASIC)
        @diary.assign_attributes(body: body_sanitize)
      end

      if @diary.save
        flash[:notice] = '日記を投稿しました'
        redirect_to @diary
      else
        render :new
      end
    else
      redirect_to root_path
    end
  end

  def edit
    if current_user.id == params[:user_id].to_i #管理者であっても日記の編集は出来ない
      @diary = Diary.find(params[:id])
      @tag = Tag.new
    else
      redirect_to root_path
    end
  end

  def destroy
    if current_user.id == params[:user_id].to_i || current_user.admin? #管理者であれば全日記の削除権限がある
      diary = Diary.find(params[:id])
      diary.destroy
      flash[:notice] = '日記を削除しました'
      redirect_to diaries_path
    else
      redirect_to root_path
    end
  end

  def update
    if current_user.id == params[:user_id].to_i
      @diary = Diary.find(params[:id])
      unless current_user.admin? #管理者以外の場合
        @diary.assign_attributes(diary_params)
        @diary.body.gsub!(/<|>/, "<" => "&lt;", ">" => "&gt;")
        @diary.update_attributes(body: Sanitize.clean(@diary.body, Sanitize::Config::BASIC))
      else #管理者の場合
        @diary.update(diary_params)
      end

      if @diary.valid? #上記の分岐処理が有効かどうか
        flash[:notice] = '日記を更新しました'
        redirect_to @diary
      else
        render :edit
      end
    else
      redirect_to root_path
    end
  end

  private

  def diary_params
    params.require(:diary).permit(:user_id, :title, :body, :diary_image, tag_ids: [])
  end

end
