require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  scenario "無効な情報にログイン" do
    visit login_path
    fill_in "Email", with: ""
    fill_in "パスワード", with: ""
    click_button "ログイン" 
    expect(page).to have_content "メール/パスワードの組み合わせが無効です"
  end

  scenario "有効な情報にログインしてログアウト" do
    FactoryBot.create(:user)
    visit login_path
    fill_in "Email", with: "yamamoto@email.com"
    fill_in "パスワード", with: "yamamoto"
    click_button "ログイン" 
    expect(page).to have_content "yamamoto"
    click_link "Log out"
    expect(page).to_not have_content "Log out"
  end

  scenario "ゲストログインでログインする" do
    visit login_path
    click_link "ゲストログイン"
    expect(page).to have_content "ゲストログインしました。"
  end
end
