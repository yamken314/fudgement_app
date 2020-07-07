require "rails_helper"

RSpec.describe "UsersIndex", type: :request do
  let(:user){FactoryBot.create(:user)}

  it "ログインしていない時ユーザー一覧へアクセス出来ない" do
    get users_path(user)
    expect(response).to redirect_to login_url
  end
end