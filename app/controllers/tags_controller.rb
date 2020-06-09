class TagsController < ApplicationController
  before_action :authenticate_user!
  include TagsHelper

  def index
    @tags = Tag.all.order(id: 'DESC')
  end

  def create
    tags = Tag.select("name")
    tags.each do |old|
      if tag_dup_valid(params[:name]) == tag_dup_valid(old.name)
        flash[:notice] = "タグが重複しています"
        return redirect_back(fallback_location: root_path)
      end
    end
    tag = Tag.create(name: params[:name])
    flash[:notice] = "タグを追加しました"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    tag = Tag.find(params[:id])
    if tag.destroy
      flash[:notice] = 'タグを削除しました'
      redirect_to tags_path
    else
      render :index
    end
  end

  def update
    if current_user.admin?
      tag = Tag.find(params[:id])
      if tag.update(tag_params)
        flash[:notice] = 'タグを更新しました'
        redirect_to tags_path
      else
        render :index
      end
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

end
