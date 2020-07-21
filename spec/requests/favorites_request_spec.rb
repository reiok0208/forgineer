require 'rails_helper'

RSpec.describe "お気に入りコントローラー", type: :request do
  before do
    @user = create(:user)
    @diary = create(:diary, user: @user)
    sign_in @user
  end

  describe 'お気に入りテスト' do
    it 'お気に入りをすることができる' do
      expect do
        post diary_favorites_path(@diary), xhr: true
      end.to change(Favorite, :count).by(1)
    end
    it 'お気に入りを外すことができる' do
      expect do
        post diary_favorites_path(@diary), xhr: true
      end.to change(Favorite, :count).by(1)
      expect do
        delete diary_favorites_path(@diary), xhr: true
      end.to change(Favorite, :count).by(-1)
    end
  end
end
