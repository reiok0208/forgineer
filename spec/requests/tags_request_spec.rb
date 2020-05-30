require 'rails_helper'

RSpec.describe "Tags", type: :request do
  before do
    user = User.create(
      name: "テスト太郎",
      nickname:  "テスト",
      email:      "test@example.com",
      password:   "testTarou1111",
      admin: 1,
    )
    sign_in user
  end

  describe 'タグ一覧ページ' do
    context "（管理者のみ）タグ一覧ページが正しく表示される" do
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
end
