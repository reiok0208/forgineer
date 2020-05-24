class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    @favorite = Favorite.create(user_id: current_user.id, diary_id: params[:diary_id])
    redirect_to diaries_path
  end

  def destroy
    current_user.favorites.find_by(diary_id: params[:diary_id]).destroy!
    redirect_to diaries_path
  end
end
