require 'rails_helper'

feature 'タグ統合テスト', type: :feature do
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: 1) }
  before do
    create(:tag)
  end

  scenario 'タグ編集削除テスト' do
    # ログイン前は全てのタグリンク(index_side全般)は表示されない
    visit diaries_path
    expect(page).to have_no_content('全てのタグ')

    # ログインすると全てのタグリンクが表示される
    sign_in user
    visit diaries_path
    expect(page).to have_content('全てのタグ')
    click_on ("全てのタグ")
    expect(current_path).to eq tags_path
    #DBに格納したタグが存在するか確認
    expect(page).to have_content('機能1')
    #一般ユーザーはタグの編集、削除は表示されていない
    expect(page).to have_no_field 'tag[name]', with: '機能1'
    expect(page).to have_no_selector 'a[data-confirm="タグを削除しますか？"]'
    click_on "ログアウト", match: :first

    sign_in admin
    visit tags_path
    expect(page).to have_field 'tag[name]', with: '機能1'
    #タグを正常に編集できるか確認
    fill_in 'tag[name]', with: "更新"
    click_on "更新"
    #タグ「機能１」が「更新」に変わっているか確認
    expect(page).to have_no_field 'tag[name]', with: '機能1'
    expect(page).to have_field 'tag[name]', with: '更新'

    #タグを正常に削除できるか確認
    expect(page).to have_selector 'a[data-confirm="タグを削除しますか？"]'
    find(".fa-trash-alt").click
  end
end