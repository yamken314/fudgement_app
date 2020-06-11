require 'rails_helper'

RSpec.feature "UsersSignups", type: :feature do
  let(:user) {FactoryBot.create(:user)}

  scenario "無効なユーザーのサインアップ" do
    visit signup_path
    fill_in "Email", with: "yamamoto@invalid"
    fill_in "ユーザー名",with: " "
    fill_in "パスワード",with: "foo"
    fill_in "パスワード確認",with: "foo"
    click_button "新規作成"
    expect(page).to have_content "問題があります。"
  end


end
