class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def follow
    if current_user.id == params[:user_id].to_i
      current_user.follow(params[:id])
      flash[:notice] = 'フォローしました'
      redirect_back(fallback_location: root_path)
    else
      redirect_to root_path
    end
  end

  def unfollow
    if current_user.id == params[:user_id].to_i
      current_user.unfollow(params[:id])
      flash[:notice] = 'アンフォローしました'
      redirect_back(fallback_location: root_path)
    else
      redirect_to root_path
    end
  end
end
