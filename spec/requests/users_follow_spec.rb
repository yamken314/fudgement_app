require "rails_helper"

RSpec.describe "UsersFollow", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  it "ユーザーをフォローする、存在を確認する" do
    user.follow(other_user)
    expect(user.following?(other_user)).to be true
  end

  it "ユーザーのフォローを解除する" do
    user.follow(other_user)
    user.unfollow(other_user)
    expect(user.following?(other_user)).to be false
  end
end
