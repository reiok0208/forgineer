require 'rails_helper'

RSpec.describe "関係コントローラー", type: :request do
  before do
    @user = create(:user)
    @other_user = create(:user)
    sign_in @user
  end

  describe 'フォロー&フォロワーテスト' do
    before do
      get user_path(@other_user)
    end
    it 'フォローをすることができる' do
      expect {
        post user_follow_path(@other_user)
      }.to change(Relationship, :count).by(1)
      expect(flash[:notice]).to include("フォローしました")
    end
    it 'フォローを外すことができる' do
      @user.follow(@other_user.id)
      expect {
        post user_unfollow_path(@other_user)
      }.to change(Relationship, :count).by(-1)
      expect(flash[:notice]).to include("アンフォローしました")
    end
  end
end
