require "rails_helper"

RSpec.describe "UsersSignups", type: :request do
  let(:user){FactoryBot.create(:user)}

  example "有効な情報でサインアップして連続ログアウト" do
    get signup_path
    expect{
      post users_path, params: { user: { name:  "Example User",
        email: "user@example.com",
        password:              "password",
        password_confirmation: "password" } }
    }.to change(User, :count).by(1)
    
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?

    expect{
      delete login_path, params: { user: { name:  "Example User",
        email: "user@example.com",
        password:              "password",
        password_confirmation: "password" }}
      }.to change(User, :count).by(0)
    expect{
      delete login_path, params: { user: { name:  "Example User",
        email: "user@example.com",
        password:              "password",
        password_confirmation: "password" }}
      }.to change(User, :count).by(0)
  end

  context "自動ログインテスト" do
    it "自動ログインを選択" do
      post login_path, params: { session: { email: user.email,
                                            password: user.password,
                                            remember_me: '1'}}
      expect(cookies['remember_token']).to_not eq nil
      expect(assigns(:user).remember_token).to_not eq nil
    end

    it "自動ログインを選択しない" do
      post login_path, params: { session: { email: user.email,
                                            password: user.password,
                                            remember_me: '0'}}
      expect(cookies['remember_token']).to eq nil
      expect(assigns(:user).remember_token).to eq nil
    end
  end
end