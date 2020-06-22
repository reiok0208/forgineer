class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @diary = Diary.find(params[:diary_id])
    @favorite = Favorite.create(user_id: current_user.id, diary_id: params[:diary_id])
    render 'asynchronous'
  end

  def destroy
    @diary = Diary.find(params[:diary_id])
    current_user.favorites.find_by(diary_id: params[:diary_id]).destroy!
    render 'asynchronous'
  end
end
