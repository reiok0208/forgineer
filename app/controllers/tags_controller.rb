class TagsController < ApplicationController
  before_action :authenticate_user!
  include TagsHelper
  def index
    if current_user.admin?
      @tags = Tag.all.order(id: 'DESC')
    else
      redirect_to root_path
    end
  end

  def create
    new_tag = params[:name]
    tag_downcase = new_tag.downcase
    tag_space_delete = tag_downcase.gsub(/ |　/){""}
    tag = Tag.new(name: tag_space_delete)
    if tag.save
      flash[:notice] = "タグを追加しました"
    elsif
      flash[:notice] = "タグを追加できませんでした"
    end
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
    tag = Tag.find(params[:id])
    if tag.update(tag_params)
      flash[:notice] = 'タグを更新しました'
      redirect_to tags_path
    else
      render :index
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

end
