require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  scenario "無効な情報にログイン" do
    user = FactoryBot.create(:user)
    visit login_path
    fill_in "Email", with: ""
    fill_in "パスワード", with: ""
    click_button "ログイン" 

    expect(page).to have_content "メール/パスワードの組み合わせが無効です"
  end
end
