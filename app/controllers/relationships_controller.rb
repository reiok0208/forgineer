class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def follow
    current_user.follow(params[:id])
    flash[:notice] = 'フォローしました'
    redirect_back(fallback_location: root_path)
  end

  def unfollow
    current_user.unfollow(params[:id])
    flash[:notice] = 'アンフォローしました'
    redirect_back(fallback_location: root_path)
  end
end
