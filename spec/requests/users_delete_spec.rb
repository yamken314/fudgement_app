require "rails_helper"

RSpec.describe "UsersDelete", type: :request do
  let(:user){FactoryBot.create(:user)}
  let(:other_user){FactoryBot.create(:other_user)}

  it "管理ユーザーとして他のユーザーを削除する" do
    other_user
    sign_in_as(user)
    expect{delete user_path(other_user), params: {id: other_user.id}}
    .to change(User, :count).by(-1)
  end

  it "ユーザーを削除すれば、紐ずけられたMicropostは破棄される"do
    user.microposts.create(content: "おはようございます")
    expect{user.destroy}.to change(Micropost, :count).by(-1)
  end
end