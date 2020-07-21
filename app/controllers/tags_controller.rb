class TagsController < ApplicationController
  before_action :authenticate_user!
  include TagsHelper

  def index
    @tags = Tag.all.order(id: 'DESC')
  end

  def create
    tags = Tag.select("name")
    new_name = replace(params[:name])
    tags.each do |old|
      if tag_dup_valid(new_name) == tag_dup_valid(old.name) # 新規タグと既存タグを比較
        flash[:notice] = "タグが重複しています"
        return redirect_back(fallback_location: root_path) # 重複していれば新規タグは破棄
      end
    end
    tag = Tag.new(name: new_name) # 重複していなければ入力した新規タグをDBに保存
    if tag.save
      flash[:notice] = "タグを追加しました"
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = "タグを追加できませんでした。タグは1文字以上20文字以内です。"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    if current_user.admin?
      tag = Tag.find(params[:id])
      tag.destroy
      flash[:notice] = 'タグを削除しました'
      redirect_to tags_path
    else
      redirect_to root_path
    end
  end

  def update
    if current_user.admin?
      tag = Tag.find(params[:id])
      if tag.update(tag_params)
        flash[:notice] = 'タグを更新しました'
        redirect_to tags_path
      else
        @tags = Tag.all.order(id: 'DESC')
        render :index
      end
    else
      redirect_to root_path
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
