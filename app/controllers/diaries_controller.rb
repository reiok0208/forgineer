class DiariesController < ApplicationController

  def new
  end

  def index
    @diaries = Diary.all.order(id: "DESC")
    @tags = Tag.all
  end

  def show
  end

  def create
  end

  def edit
  end

  def destroy
  end

  def update
  end
end
