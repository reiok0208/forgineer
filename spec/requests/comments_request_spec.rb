require 'rails_helper'

RSpec.describe "Comments", type: :request do
  before do
    @user = create(:user)
    @admin = create(:user, admin: 1)
    @diary = create(:diary, user: @user)
    @user_comment = create(:comment, user: @user, diary: @diary)
    @admin_comment = create(:comment, user: @admin, diary: @diary)
    @notuser_comment = create(:comment, diary: @diary)
  end

  describe '画面遷移テスト' do
    before do
      sign_in @user
    end
    context "コメント編集ページが正しく表示される" do
      before do
        get edit_diary_comment_path(diary_id: @diary, id: @user_comment)
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'editテンプレートで表示されること' do
        expect(response).to render_template :edit
      end
      it '文字列「コメント編集」が正しく表示されていること' do
        expect(response.body).to include("コメント編集")
      end
      it '他のユーザーのidでコメント編集へ遷移した場合トップに戻る' do
        get edit_diary_comment_path(diary_id: @diary, id: @admin_comment)
        expect(response).to redirect_to root_path
      end
      it '非会員がコメント編集へ遷移した場合サインインを求める' do
        sign_out @user
        get edit_diary_comment_path(diary_id: @diary, id: @notuser_comment)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'コメント追加・コメント編集・コメント削除テスト' do
    before do
      get diary_path(@diary)
    end
    context "管理者の場合" do
      before do
        sign_in @admin
      end
      it '正常にコメントを追加できる' do
        expect {
          post diary_comments_path(@diary), xhr: true, params: { comment: {title: "コメント", body: "コメント"} }
        }.to change(Comment, :count).by(1)
      end
      it 'タイトルが30文字を超えた場合コメントを追加できない' do
        expect {
          post diary_comments_path(@diary), xhr: true, params: { comment: {title: "コメント" * 10, body: "コメント"} }
        }.to change(Comment, :count).by(0)
      end
      it '正常にコメントを更新できる' do
        expect {
          patch diary_comment_path(@admin_comment), params: { comment: {title: "更新", body: "更新"} }
        }.to change(Comment, :count).by(0)
        expect(flash[:notice]).to include("コメントを更新しました")
      end
      it 'タイトルが30文字を超えた場合コメントを追加できない' do
        expect {
          patch diary_comment_path(@admin_comment), params: { comment: {title: "コメント" * 10, body: "コメント"} }
        }.to change(Comment, :count).by(0)
        expect(flash[:notice]).to include("コメントを更新できませんでした。タイトルは1文字以上30文字以内です。")
      end
      it '正常に自分のコメントを削除できる' do
        expect {
          delete diary_comment_path(diary_id: @diary, id: @admin_comment), xhr: true
        }.to change(Comment, :count).by(-1)
      end
      it '正常に他人のコメントを削除できる' do
        expect {
          delete diary_comment_path(diary_id: @diary, id: @user_comment), xhr: true
        }.to change(Comment, :count).by(-1)
      end
    end

    context "一般ユーザーの場合" do
      before do
        sign_in @user
      end
      it '正常にコメントを追加できる' do
        expect {
          post diary_comments_path(@diary), xhr: true, params: { comment: {title: "コメント", body: "コメント"} }
        }.to change(Comment, :count).by(1)
      end
      it '正常にコメントを更新できる' do
        expect {
          patch diary_comment_path(@user_comment), params: { comment: {title: "更新", body: "更新"} }
        }.to change(Comment, :count).by(0)
        expect(flash[:notice]).to include("コメントを更新しました")
      end
      it '正常に自分のコメントを削除できる' do
        expect {
          delete diary_comment_path(diary_id: @diary, id: @user_comment), xhr: true
        }.to change(Comment, :count).by(-1)
      end
      it '他人のコメントを削除できない' do
        expect {
          delete diary_comment_path(diary_id: @diary, id: @admin_comment), xhr: true
        }.to change(Comment, :count).by(0)
      end
    end

    context "非会員の場合" do
      it '正常にコメントを追加できる' do
        expect {
          post diary_comments_path(@diary), xhr: true, params: { comment: {title: "コメント", body: "コメント"} }
        }.to change(Comment, :count).by(1)
      end
      it 'コメントを更新できない' do
        expect {
          patch diary_comment_path(@notuser_comment), params: { comment: {title: "更新", body: "更新"} }
        }.to change(Comment, :count).by(0)
      end
      it 'コメントを削除できない' do
        expect {
          delete diary_comment_path(diary_id: @diary, id: @notuser_comment)
        }.to change(Comment, :count).by(0)
      end
    end
  end
end
