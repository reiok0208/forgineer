class DiariesController < ApplicationController
  include DiariesHelper
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit, :update]
  impressionist :actions=>[:show]

  def new
    @diary = Diary.new
    @tag = Tag.new
    if params[:name].present?
      tagcreate(params[:name])
      render :new
    end
  end

  def index
    #indexアクションにtag_idがパラメーターで送られたときに存在していればそのtag_idに紐付いた日記を@diariesに渡す。
    @diaries = params[:tag_id].present? ? Tag.find(params[:tag_id]).diaries : Diary.search(params[:search]).page(params[:page]).per(PER)
    @tags = Tag.all
    @most_viewed = Diary.order('impressions_count DESC').take(10)
  end

  def show
    @diary = Diary.find(params[:id])
    impressionist(@diary)
  end

  def create
    @diary = Diary.new(diary_params)
    if @diary.save
      redirect_to @diary
    else
      render :new
    end
  end

  def edit
    @diary = Diary.find(params[:id])
    @tag = Tag.new
    if params[:name].present?
      tagcreate(params[:name])
      render :edit
    end
  end

  def destroy
    diary = Diary.find(params[:id])
    if diary.destroy
      redirect_to diaries_path
    else
      render :show
    end
  end

  def update
    @diary = Diary.find(params[:id])
    if @diary.update(diary_params)
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
