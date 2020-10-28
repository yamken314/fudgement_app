require 'rails_helper'

RSpec.describe "Relationships", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  it "ユーザーをフォロー、フォロー解除出来る" do
    log_in_as(user)
    visit user_path(other_user)
    click_button "commit" # Follow_button
    expect(user.following?(other_user)).to be true
    click_button "commit" # Unfollow_button
    expect(user.following?(other_user)).to be false
  end
end
