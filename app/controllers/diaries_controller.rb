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
  end

  def create
    @diary = Diary.new(diary_params)
    if @diary.save
      redirect_to user_diary_path(@diary)
    else
      render :new
    end
  end

  def edit
  end

  def destroy
  end

  def update
  end

  private

  def diary_params
    params.require(:diary).permit(
      :user_id,
      :title,
      :body,
      :diary_image
    )
  end
end
