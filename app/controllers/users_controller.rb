class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def delete
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
    @diaries = @user.favorite_diaries.page(params[:page]).per(PER)
  end

  def comments
    @user = User.find(params[:user_id])
    @diaries = @user.comment_diaries.page(params[:page]).per(PER)
  end
end
