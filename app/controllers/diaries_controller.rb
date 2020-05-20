class DiariesController < ApplicationController
  before_action :authenticate_user!

  def new
    @diary = Diary.new
  end

  def index
    @diaries = Diary.all.order(id: "DESC")
    @tags = Tag.all
  end

  def show
    @diary = Diary.find(params[:id])
    @diary_tags = DiaryTag.where(diary_id: params[:id])
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
  end

  private

  def diary_params
    params.require(:diary).permit(:user_id, :title, :body, :diary_image, tag_ids: [])
  end

end
