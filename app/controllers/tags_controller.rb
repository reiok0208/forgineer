class TagsController < ApplicationController
  def index
    if current_user.admin?
      @tags = Tag.all.order(id: 'DESC')
    else
      redirect_to root_path
    end
  end

  def destroy
    tag = Tag.find(params[:id])
    if tag.destroy
      redirect_to tags_path
    else
      render :index
    end
  end

  def update
    tag = Tag.find(params[:id])
    if tag.update(tag_params)
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
