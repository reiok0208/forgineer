require 'rails_helper'

RSpec.describe "日記コントローラー", type: :request do
  before do
    @user = create(:user)
    @user2 = create(:user)
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
      it '他のユーザーのidで新規投稿へ遷移した場合トップに戻る' do
        get new_user_diary_path(@user2)
        expect(response).to redirect_to root_path
      end
    end

    context "日記編集ページが正しく表示される" do
      before do
        get edit_user_diary_path(@diary, @user)
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
      it '他のユーザーのidで日記編集へ遷移した場合トップに戻る' do
        get edit_user_diary_path(@user2)
        expect(response).to redirect_to root_path
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
      it '文字列「日記一覧」が正しく表示されていること' do
        expect(response.body).to include("日記一覧")
      end
      it 'params[search]が含まれていた場合、文字列「フォーム検索」が正しく表示されていること' do
        get diaries_path(search: "user")
        expect(response.body).to include("フォーム検索")
      end
      it 'params[tag_id]が含まれていた場合、文字列「タグ検索」が正しく表示されていること' do
        get diaries_path(tag_id: 1)
        expect(response.body).to include("タグ検索")
      end
      it 'params[user_id]が含まれていた場合、文字列「さんの投稿日記」が正しく表示されていること' do
        get diaries_path(user_id: @user.id)
        expect(response.body).to include("さんの投稿日記")
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

  describe '日記投稿・日記編集・日記削除テスト' do
    context "カレントユーザーの場合" do
      it "正常に日記を投稿できる" do
        expect do
          post user_diaries_path(@user), params: { diary: { title: "日記", body: "日記", user_id: @user.id } }
        end.to change(@user.diaries, :count).by(1)
        expect(flash[:notice]).to include("日記を投稿しました")
      end
      it "不足項目がある場合新規投稿できない" do
        expect do
          post user_diaries_path(@user), params: { diary: { title: "", body: "日記", user_id: @user.id } }
        end.to change(@user.diaries, :count).by(0)
        expect(response).to render_template :new
      end

      it "正常に日記を更新できる" do
        expect do
          patch user_diary_path(user_id: @user, id: @diary), params: { diary: { title: "更新", body: "更新", user_id: @user.id } }
        end.to change(@user.diaries, :count).by(0)
        expect(flash[:notice]).to include("日記を更新しました")
      end
      it "不足項目がある場合更新できない" do
        expect do
          patch user_diary_path(user_id: @user, id: @diary), params: { diary: { title: "", body: "更新", user_id: @user.id } }
        end.to change(@user.diaries, :count).by(0)
        expect(response).to render_template :edit
      end

      it "正常に日記を削除できる" do
        expect do
          delete user_diary_path(user_id: @user, id: @diary)
        end.to change(@user.diaries, :count).by(-1)
        expect(flash[:notice]).to include("日記を削除しました")
      end
    end

    context "他ユーザーidの場合" do
      it "投稿しようとするとトップ画面にリダイレクトする" do
        expect do
          post user_diaries_path(@user2), params: { diary: { title: "日記", body: "日記", user_id: @user.id } }
        end.to change(@user.diaries, :count).by(0)
        expect(response).to redirect_to root_path
      end

      it "更新しようとするとトップ画面にリダイレクトする" do
        expect do
          patch user_diary_path(user_id: @user2, id: @diary), params: { diary: { title: "更新", body: "更新", user_id: @user.id } }
        end.to change(@user.diaries, :count).by(0)
        expect(response).to redirect_to root_path
      end

      it "削除しようとするとトップ画面にリダイレクトする" do
        expect do
          delete user_diary_path(user_id: @user2, id: @diary)
        end.to change(@user.diaries, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end
  end
end
