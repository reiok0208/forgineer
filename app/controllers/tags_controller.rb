class TagsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
  end

  def destroy
  end

  def update
  end

  private
  def tag_params
    params.require(:tag).permit(:name, :description)
  end
end
