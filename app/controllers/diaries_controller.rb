class DiariesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit, :update]
  impressionist :actions=>[:show]

  def new
    if current_user.id == params[:user_id].to_i
      @diary = Diary.new
      @tag = Tag.new
    else
      redirect_to root_path
    end
  end

  def index
    @tags = Tag.all
    @most_viewed = Diary.order('impressions_count DESC').take(10)
    #indexアクションにtag_idがパラメーターで送られたときに存在していればそのtag_idに紐付いた日記を@diariesに渡す。
    if params["user_id"].nil?
      @diaries = params[:tag_id].present? ? Tag.find(params[:tag_id]).diaries.page(params[:page]).per(PER) : Diary.search(params[:search]).page(params[:page]).per(PER)
    else
      @diaries = Diary.where(user_id: params["user_id"]).page(params[:page]).per(PER)
    end
  end

  def show
    @diary = Diary.find(params[:id])
    @comments = Comment.where(diary_id: params[:id])
    impressionist(@diary)
    @comment = Comment.new
  end

  def create
    @diary = Diary.new(diary_params)
    if @diary.save
      flash[:notice] = '日記を投稿しました'
      redirect_to @diary
    else
      render :new
    end
  end

  def edit
    if current_user.id == params[:user_id].to_i
      @diary = Diary.find(params[:id])
      @tag = Tag.new
    else
      redirect_to root_path
    end
  end

  def destroy
    diary = Diary.find(params[:id])
    if diary.destroy
      flash[:notice] = '日記を削除しました'
      redirect_to diaries_path
    else
      render :show
    end
  end

  def update
    @diary = Diary.find(params[:id])
    if @diary.update(diary_params)
      flash[:notice] = '日記を更新しました'
      redirect_to @diary
    else
      render :edit
    end
  end

  private

  def diary_params
    params.require(:diary).permit(:user_id, :title, :body, :diary_image, tag_ids: [])
  end

end
