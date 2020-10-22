require 'rails_helper'

RSpec.describe Vote, type: :model do
  before do
    @micropost = FactoryBot.create(:micropost)
    @choice = Choice.create!(name: "test", user_id: @micropost.user.id, micropost_id: @micropost.id)
    @vote = Vote.create!(choice_id: @choice.id, user_id: @micropost.user.id)
  end
  it "voteは有効" do
    expect(@vote).to be_valid
  end

  it "voteはuser_idが無ければ無効" do
    @vote.user_id = nil
    @vote.valid?
    expect(@vote).to_not be_valid
  end

  it "voteはchoice_idが無ければ無効" do
    @vote.choice_id = nil
    @vote.valid?
    expect(@vote).to_not be_valid
  end
end
