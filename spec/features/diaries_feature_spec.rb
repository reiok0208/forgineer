require 'rails_helper'

feature '日記統合テスト', type: :feature do
  let(:user) { create(:user, admin: 1) }
  before do
    @user = create(:user, admin: 1)
    @diary = create(:diary, user: @user)
  end

  scenario 'ログイン・新規投稿・タグ新規追加' do
    # ログイン前は投稿するボタンが表示されない
    visit root_path
    expect(page).to have_no_content('新規投稿')

    # ログインすると投稿ボタンが表示される
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on("commit")
    expect(current_path).to eq diaries_path
    expect(page).to have_content('新規投稿')

    # 投稿ボタンから記事を投稿する
    expect {
      click_on "新規投稿", match: :first
      expect(current_path).to eq new_user_diary_path(user)
      expect {
        fill_in 'name', with: "日記のタグ"
        click_on "タグを追加"
        select '日記のタグ', from: 'diary[tag_ids][]'
      }.to change{ Tag.count }.by(1)
      fill_in 'diary[title]', with: "日記のタイトル"
      fill_in 'diary[body]', with: "日記の本文"
      click_on "投稿"
    }.to change{ Diary.count }.by(1)

    #リダイレクト先の確認、日記にタグが紐付いているかの確認
    expect(current_path).to eq "/diaries/2"
    expect(page).to have_content('日記のタグ')
  end


  scenario '日記編集・日記削除テスト', :js => true do
    sign_in @user
    visit diary_path(@diary)
    expect(current_path).to eq diary_path(@diary)
    #日記編集が正常に行われるか確認
    click_on "編集"
    expect(current_path).to eq edit_user_diary_path(user_id: @user, id: 1)
    expect {
      fill_in 'diary[title]', with: "編集完了"
      fill_in 'diary[body]', with: '```rb
                                    ```'
      click_on "更新"
    }.not_to change{ Diary.count }
    expect(current_path).to eq "/diaries/1"
    expect(page).to have_content('日記を更新しました')
    expect(page).to have_content('編集完了')

    #日記削除が正常に行われるか確認
    find(".btn-danger").click
    expect {
      expect(page.driver.browser.switch_to.alert.text).to eq "日記を削除しますか？"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content '日記を削除しました'       
    }.to change{ Diary.count }.by(-1)
  end
end