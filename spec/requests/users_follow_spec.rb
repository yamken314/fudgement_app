require "rails_helper"

RSpec.describe "UsersFollow", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  before { user.follow(other_user) }
  it "ユーザーをフォローしているか、確認する" do
    expect(user.following?(other_user)).to be true
  end

  it "ユーザーのフォローを解除する" do
    user.unfollow(other_user)
    expect(user.following?(other_user)).to be false
  end
end
