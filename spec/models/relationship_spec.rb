require 'rails_helper'

RSpec.describe Relationship, type: :model do
    let(:user) { create(:user) }
    let(:other_user) { create(:other_user) }
    let(:active) { user.active_relationships.build(followed_id: other_user.id) }
    let(:passive) { user.passive_relationships.build(follower_id: other_user.id) }
  it "active_relationshipsメソッドは有効" do
    active.valid?
    expect(active).to be_valid
  end

  it "passive_relationshipsメソッドは有効" do
    passive.valid?
    expect(passive).to be_valid
  end

  it "relarionshipsモデルはfollower_idが必要" do
    active.follower_id = nil
    active.valid?
    expect(active).to_not be_valid
  end

  it "relationshipsモデルはfollowed_idが必要" do
    active.followed_id = nil
    active.valid?
    expect(active).to_not be_valid
  end

  describe "follower/followed methods" do
    it "followerメソッドは、フォローしているユーザを返すこと" do
      expect(active.follower). to eq user
    end

    it "followedメソッドは、フォローされているユーザを返すこと" do
      expect(active.followed). to eq other_user
    end
  end
end
