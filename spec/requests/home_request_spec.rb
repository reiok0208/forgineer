require 'rails_helper'

RSpec.describe "Home", type: :request do
  before do
    @user = create(:user)
  end

  describe '画面遷移テスト' do
    context "トップページが正しく表示される" do
      before do
        get root_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'topテンプレートで表示されること' do
        expect(response).to render_template :top
      end
      it '文字列「See more」が正しく表示されていること' do
        expect(response.body).to include("See more")
      end
    end

    context "Aboutページが正しく表示される" do
      before do
        get home_about_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'aboutテンプレートで表示されること' do
        expect(response).to render_template :about
      end
      it '文字列「記憶力」が正しく表示されていること' do
        expect(response.body).to include("記憶力")
      end
    end

    context "infoページが正しく表示される" do
      before do
        get home_info_path(@user)
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it 'infoテンプレートで表示されること' do
        expect(response).to render_template :info
      end
      it '文字列「お問い合わせ」が正しく表示されていること' do
        expect(response.body).to include("お問い合わせ")
      end
    end
  end

  describe 'お問い合わせテスト' do
    it 'お問い合わせ(メール送信)することができる' do
      expect {
        post home_info_path, params: { inquiry: {name:"名前", message:"メッセージ"} }
      }.to change(Inquiry, :count).by(1)
    end
    it 'お問い合わせ(メール送信)に失敗する(文字制限)' do
      expect {
        post home_info_path, params: { inquiry: {name:"", message:"メッセージ"} }
      }.to change(Inquiry, :count).by(0)
    end
  end
end
