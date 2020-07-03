require "rails_helper"

RSpec.describe "UsersEdit", type: :request do
  let(:user){FactoryBot.create(:user)}
  
    it "ユーザー編集を失敗する" do
      user = FactoryBot.create(:user)
      get edit_user_path(user)
      sign_in_as(user)
        patch user_path(user), params: { user: { name:  "",
          email: "foo@invalid",
          password:              "foo",
          password_confirmation: "bar" } }
      expect(user.reload.email).to_not eq "foo@invalid"
    end
    it "ユーザー編集を成功する" do
      get edit_user_path(user)
      sign_in_as(user)
        patch user_path(user), params: { user: { name:  "yamken",
          email: "yamken314@email.com",
          password:              "yamamoto",
          password_confirmation: "yamamoto" } }
          
      expect(user.reload.email).to eq "yamken314@email.com"
    end

    it "ログインしていないユーザーは編集出来ない" do
      get edit_user_path(user)
      expect(response).to redirect_to login_url
    end

end