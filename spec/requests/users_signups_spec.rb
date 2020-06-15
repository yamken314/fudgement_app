require "rails_helper"

RSpec.describe "UsersSignups", type: :request do
  example "有効な情報でサインアップ" do
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
  end
end