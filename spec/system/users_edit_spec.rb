require 'rails_helper'

RSpec.describe "UsersEdit", type: :system do
  let(:user) {FactoryBot.create(:user)}
  
  scenario "ユーザー編集を失敗する" do
    log_in_as(user)
    visit edit_user_path(user)
    fill_in "Email", with: "yamamoto@invalid"
    fill_in "ユーザー名",with: "yamamoto"
    fill_in "パスワード",with: "foo"
    fill_in "パスワード確認",with: "foo"
    click_button "編集"
    expect(page).to have_content "Passwordは6文字以上で入力してください"
  end

  scenario "ユーザー編集を成功する" do
    log_in_as(user)
    visit edit_user_path(user)
    fill_in "Email", with: "new-yamamoto@email.com"
    fill_in "ユーザー名",with: "new-yamamoto"
    fill_in "パスワード",with: "yamamoto"
    fill_in "パスワード確認",with: "yamamoto"
    click_button "編集"
    expect(page).to have_content "編集しました"
  end
end