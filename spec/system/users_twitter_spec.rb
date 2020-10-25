require 'rails_helper'

RSpec.describe 'UsersTwitter', type: :system do
  before do
    @user = FactoryBot.create(:user)
    OmniAuth.config.mock_auth[:twitter] = nil
  end

  context 'Twitter認証ができるとき' do
    it 'ログインボタンを押してユーザーがTwitter認証を許可した時' do
      Rails.application.env_config['omniauth.auth'] = twitter_mock
      visit login_path
      expect(page).to_not have_content('My page')
      click_link 'Twitterアカウントでログイン'
      expect(page).to have_content('ユーザー認証が完了しました。')
    end
  end
  context 'Twitter認証ができないとき' do
    it 'ログインボタンを押してユーザーがTwitter認証をキャンセルした時' do
      Rails.application.env_config['omniauth.auth'] = twitter_invalid_mock
      visit login_path
      expect(page).to_not have_content('My page')
      click_link 'Twitterアカウントでログイン'
      expect(page).to have_content('ログインをキャンセルしました。')
    end
  end
end
