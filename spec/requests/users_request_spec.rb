require 'rails_helper'

RSpec.describe "ユーザーコントローラー", type: :request do
  before do
    @user = create(:user)
    @user2 = create(:user)
    sign_in @user
  end

  describe '画面遷移テスト' do
    context "ユーザー詳細ページが正しく表示される" do
      before do
        get user_path(@user)
      end

      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'showテンプレートで表示されること' do
        expect(response).to render_template :show
      end
      it '文字列「ユーザー詳細」が正しく表示されていること' do
        expect(response.body).to include("ユーザー詳細")
      end
    end

    context "ユーザー編集ページが正しく表示される" do
      before do
        get edit_user_registration_path(@user)
      end

      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'editテンプレートで表示されること' do
        expect(response).to render_template :edit
      end
      it '文字列「登録情報編集」が正しく表示されていること' do
        expect(response.body).to include("登録情報編集")
      end
    end

    context "ユーザー退会ページが正しく表示される" do
      before do
        get user_delete_path(@user)
      end

      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'deleteテンプレートで表示されること' do
        expect(response).to render_template :delete
      end
      it '文字列「退会」が正しく表示されていること' do
        expect(response.body).to include("退会")
      end
      it '他のユーザーのidで退会画面へ遷移した場合トップに戻る' do
        get user_delete_path(@user2)
        expect(response).to redirect_to root_path
      end
    end

    context "お気に入り履歴ページが正しく表示される" do
      before do
        get user_favorites_path(@user)
      end

      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'favoritesテンプレートで表示されること' do
        expect(response).to render_template :favorites
      end
      it '文字列「お気に入り」が正しく表示されていること' do
        expect(response.body).to include("お気に入り")
      end
    end

    context "コメント履歴ページが正しく表示される" do
      before do
        get user_comments_path(@user)
      end

      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'commentsテンプレートで表示されること' do
        expect(response).to render_template :comments
      end
      it '文字列「コメント履歴」が正しく表示されていること' do
        expect(response.body).to include("コメント履歴")
      end
    end

    context "フォロー一覧ページが正しく表示される" do
      before do
        get user_follows_path(@user)
      end

      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'followsテンプレートで表示されること' do
        expect(response).to render_template :follows
      end
      it '文字列「フォロー一覧」が正しく表示されていること' do
        expect(response.body).to include("フォロー一覧")
      end
    end

    context "フォロワー一覧ページが正しく表示される" do
      before do
        get user_followers_path(@user)
      end

      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'followersテンプレートで表示されること' do
        expect(response).to render_template :followers
      end
      it '文字列「フォロワー一覧」が正しく表示されていること' do
        expect(response.body).to include("フォロワー一覧")
      end
    end
  end
end
