class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
  end

  def delete
    if current_user.id != params[:user_id].to_i || current_user.admin?  #管理者は削除画面へ行けないようにし、誤操作を潰す
      redirect_to root_path
    end
  end

  def follows
    @user = User.find(params[:user_id])
    @follows = @user.following_user
  end

  def followers
    @user = User.find(params[:user_id])
    @followers = @user.follower_user
  end

  def favorites
    @user = User.find(params[:user_id])
    @diaries = @user.favorite_diaries.reverse
  end

  def comments
    @user = User.find(params[:user_id])
    @comments = @user.comments.order(id: 'DESC').page(params[:page]).per(PER)
  end
end
