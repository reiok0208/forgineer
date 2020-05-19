class HomeController < ApplicationController
  def top
    @diaries = Diary.all
  end
end
