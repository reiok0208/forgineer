require 'rails_helper'

RSpec.describe "Deviseコントローラー", type: :request do
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, name: "") }

  describe '遷移テスト' do
    context 'パラメータが妥当な場合' do
      it '新規ユーザー登録が成功し、ユーザー詳細に遷移する' do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by 1
        expect(response).to redirect_to user_path(1)
      end
    end

    context 'パラメータが不正な場合' do
      it '新規ユーザー登録が失敗し、エラーが表示されること' do
        expect do
          post user_registration_path, params: { user: invalid_user_params }
        end.not_to change(User, :count)
        expect(response.body).to include '名前を入力してください'
      end
    end
  end
end
