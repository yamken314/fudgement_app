require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:relationship) { build(:relationship) }
  it "Relationshipは有効" do
    relationship.create
    relationship.valid?
    expect(relationship).to be_valid
  end

  it "Relarionshipはfollower_idが必要" do
    relationship.follower_id = nil
    relationship.valid?
    expect(relationship).to_not be_valid
  end

  it "Relationshipはfollowed_idが必要" do
    relationship.followed_id = nil
    relationship.valid?
    expect(relationship).to_not be_valid
  end
end
