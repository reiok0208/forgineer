require 'rails_helper'

RSpec.describe "Diaries", type: :request do
  before do
    @user = create(:user)
    @diary = create(:diary, user: @user)
    sign_in @user
  end

  describe '画面遷移テスト' do
    context "日記新規投稿ページが正しく表示される" do
      before do
        get new_user_diary_path(@user)
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'newテンプレートで表示されること' do
        expect(response).to render_template :new
      end
      it '文字列「新規投稿」が正しく表示されていること' do
        expect(response.body).to include("新規投稿")
      end
    end

    context "日記編集ページが正しく表示される" do
      before do
        get edit_user_diary_path(@diary,@user)
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'editテンプレートで表示されること' do
        expect(response).to render_template :edit
      end
      it '文字列「日記編集」が正しく表示されていること' do
        expect(response.body).to include("日記編集")
      end
    end

    context "日記一覧ページが正しく表示される" do
      before do
        get diaries_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'indexテンプレートで表示されること' do
        expect(response).to render_template :index
      end
      it '文字列「新着日記」が正しく表示されていること' do
        expect(response.body).to include("新着日記")
      end
    end

    context "日記詳細ページが正しく表示される" do
      before do
        get diary_path(@diary)
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'showテンプレートで表示されること' do
        expect(response).to render_template :show
      end
      it '文字列「日記詳細」が正しく表示されていること' do
        expect(response.body).to include("日記詳細")
      end
    end
  end

end
