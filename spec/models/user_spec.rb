require 'rails_helper'

RSpec.describe User, type: :model do
  it "userは有効か" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "userはnilだったら無効" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user).to_not be_valid 
  end

  it "userの名前が５１文字以上だったら無効" do
    user = FactoryBot.build(:user, name: "a"*51)
    user.valid?
    expect(user).to_not be_valid
  end

  it "userのemailが255文字以上だったら無効" do
    user = FactoryBot.build(:user, email: "a"*255+"@email.com")
    user.valid?
    expect(user).to_not be_valid
  end

  it "emailはnilだったら無効" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user).to_not be_valid 
  end

  it "emailで無効な文字列を拒否する" do
    valid_addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    valid_addresses.each do |invalid|
      expect(FactoryBot.build(:user, email: invalid)).to be_invalid
    
      # assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  it "emailのvalidateが正しく機能しているか" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    addresses.each do |invalid_address|
      expect(FactoryBot.build(:user, email: invalid_address)).to be_invalid
    end
  end
    

end
