require 'rails_helper'

RSpec.describe Choice, type: :model do
  before do
    @choice = create(:choice)
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

  it "choiceの文字数が140文字以上だったら無効" do
    @choice.name = "a" * 141
    expect(@choice).to_not be_valid
  end

  it "choiceの文字数が140字以内まで有効" do
    @choice.name = "a" * 140
    expect(@choice).to be_valid
  end
end
