require 'rails_helper'

feature 'ユーザー統合テスト', type: :feature do

  scenario '新規作成・編集・削除テスト', :js => true do
    #会員登録が正常にできるか
    visit new_user_registration_path
    expect(page).to have_content('新規会員登録')
    expect {
      fill_in 'user[name]', with: "テスト"
      fill_in 'user[nickname]', with: "テスト"
      fill_in 'user[introduction]', with: "テスト"
      fill_in 'user[email]', with: "test@mail.com"
      fill_in 'user[password]', with: "test1111"
      fill_in 'user[password_confirmation]', with: "test1111"
      find(".btn-success").click
    }.to change{ User.count }.by(1)
    expect(current_path).to eq user_path(1)

    #会員情報編集が正常にできるか
    visit edit_user_registration_path
    fill_in 'user[current_password]', with: "test1111"
    click_on "編集"
    expect(current_path).to eq user_path(1)

    #会員削除が正常にできるか
    visit user_delete_path(1)
    click_on "退会する"
    expect {
      expect(page.driver.browser.switch_to.alert.text).to eq "本当によろしいですか？"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
    }.to change{ User.count }.by(-1)
  end

end