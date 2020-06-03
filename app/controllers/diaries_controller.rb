class DiariesController < ApplicationController
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
    @tags = Tag.joins(:diary_tags).group(:tag_id).limit(10).order('count(diary_id) desc')
    @most_viewed = Diary.order('impressions_count DESC').take(10)
    if params["user_id"].nil?
      #indexアクションにtag_idがパラメーターで送られたときにそのtag_idに紐付いた日記を@diariesに渡す。
      @diaries = params[:tag_id].present? ? Tag.search(params[:tag_id]).page(params[:page]).per(PER) : Diary.search(params[:search]).page(params[:page]).per(PER)
    else
      #indexアクションにuser_idがパラメーターで送られたときにそのuser_idに紐付いた日記を@diariesに渡す。
      @diaries = Diary.where(user_id: params["user_id"]).page(params[:page]).per(PER)
    end
  end

  def show
    @diary = Diary.find(params[:id])
    @comments = Comment.where(diary_id: params[:id])
    impressionist(@diary) #日記の閲覧数を加算（日記ランキングに使用）
    @comment = Comment.new
  end

  def create
    if current_user.id == params[:user_id].to_i
      @diary = Diary.new(diary_params)
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
      if diary.destroy
        flash[:notice] = '日記を削除しました'
        redirect_to diaries_path
      else
        render :show
      end
    else
      redirect_to root_path
    end
  end

  def update
    if current_user.id == params[:user_id].to_i
      @diary = Diary.find(params[:id])
      if @diary.update(diary_params)
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
