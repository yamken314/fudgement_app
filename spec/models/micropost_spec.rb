require 'rails_helper'

RSpec.describe Micropost, type: :model do

  before do
    @user = FactoryBot.create(:user)
    @micropost = @user.microposts.create(content: "おはようございます")
  end
  
  it "Micropostは有効か"do
    expect(@micropost).to be_valid
  end

  it "Micropostはuser_idが必要"do
    @micropost.user_id = nil
    expect(@micropost).to_not be_valid
  end

  it "contentの空白は無効" do
    @micropost.content = ""
    expect(@micropost).to_not be_valid
  end

  it "contentの文字数が140文字以上だったら無効" do
    @micropost.content = "a" * 141
    expect(@micropost).to_not be_valid
  end
end
