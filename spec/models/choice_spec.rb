require 'rails_helper'

RSpec.describe Choice, type: :model do
  before do
    @micropost = FactoryBot.create(:micropost)
    @choice = Choice.create!(name: "test", user_id: @micropost.user.id, micropost_id: @micropost.id)
  end
  it "choiceは有効 " do
    expect(@choice).to be_valid
  end

  it "choiceはnameが無ければ無効" do
    @choice.name = nil
    @choice.valid?
    expect(@choice).to_not be_valid
  end

  it "choiceはuser_idが無ければ無効" do
    @choice.user_id = nil
    @choice.valid?
    expect(@choice).to_not be_valid
  end

  it "choiceはmicropost_idが無ければ無効" do
    @choice.micropost_id = nil
    @choice.valid?
    expect(@choice).to_not be_valid
  end
end
