require 'rails_helper'

RSpec.describe "タグコントローラー", type: :request do
  before do
    @user = create(:user, admin: 1)
  end

  describe '画面遷移テスト' do
    before do
      sign_in @user
    end
    context "タグ一覧ページが正しく表示される" do
      before do
        get tags_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'indexテンプレートで表示されること' do
        expect(response).to render_template :index
      end
      it '文字列「タグ一覧」が正しく表示されていること' do
        expect(response.body).to include("タグ一覧")
      end
    end
  end

  describe 'タグ追加・タグ編集・タグ削除テスト' do
    context "カレントユーザーの場合" do
      before do
        sign_in @user
      end
      it "正常にタグを追加できる" do
        expect {
          post tags_path, params: { name: "テスト" }
        }.to change(Tag, :count).by(1)
        expect(flash[:notice]).to include("タグを追加しました")
      end
      it "重複している場合タグ追加できない" do
        Tag.create(name: "テスト")
        expect {
          post tags_path, params: { name: "テスト" }
        }.to change(Tag, :count).by(0)
        expect(flash[:notice]).to include("タグが重複しています")
      end
      it "20文字を超えた場合タグ追加できない" do
        expect {
          post tags_path, params: { name: "テスト" * 10 }
        }.to change(Tag, :count).by(0)
        expect(flash[:notice]).to include("タグを追加できませんでした。タグは1文字以上20文字以内です。")
      end

      it "(管理者のみ)正常にタグを更新できる" do
        tag = create(:tag)
        expect {
          patch tag_path(tag), params: { tag: {name: "更新"} }
        }.to change(Tag, :count).by(0)
        expect(flash[:notice]).to include("タグを更新しました")
      end
      it "(管理者のみ)不足項目がある場合タグ更新できない" do
        tag = create(:tag)
        expect {
          patch tag_path(tag), params: { tag: {name: ""} }
        }.to change(Tag, :count).by(0)
        expect(response).to render_template :index
      end

      it "正常にタグを削除できる" do
        tag = create(:tag)
        expect {
          delete tag_path(tag)
        }.to change(Tag, :count).by(-1)
        expect(flash[:notice]).to include("タグを削除しました")
      end
    end

    context "管理者以外のidの場合" do
      it "タグ更新しようとするとトップ画面にリダイレクトする" do
        user2 = create(:user)
        sign_in user2
        tag = create(:tag)
        expect {
          patch tag_path(tag), params: { tag: {name: "更新"} }
        }.to change(Tag, :count).by(0)
        expect(response).to redirect_to root_path
      end

      it "タグ削除しようとするとトップ画面にリダイレクトする" do
        user2 = create(:user)
        sign_in user2
        tag = create(:tag)
        expect {
          delete tag_path(tag)
        }.to change(Tag, :count).by(0)
        expect(response).to redirect_to root_path
      end
    end
    
  end
end