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
    user = FactoryBot.create(:user)
    visit login_path
    fill_in "Email", with: "yamamoto@email.com"
    fill_in "パスワード", with: "yamamoto"
    click_button "ログイン" 
    
    expect(page).to have_content "yamamoto"

    click_link "ログアウト"
    expect(page).to_not have_content "ログアウト"
  end
end
