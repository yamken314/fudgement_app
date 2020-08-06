require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }

  before do
    @user = user.active_relationships.create(follower_id: other_user.id, followed_id: user.id)
  end

  it "Relationshipは有効" do
    @user.valid?
    expect(@user).to be_valid
  end

  it "Relarionshipはfollower_idが必要" do
    @user.follower_id = nil
    @user.valid?
    expect(@user).to_not be_valid
  end

  it "Relationshipはfollowed_idが必要" do
    @user.followed_id = nil
    @user.valid?
    expect(@user).to_not be_valid
  end
end
