require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.build(:user)
  end

  it "userは有効か" do
    expect(@user).to be_valid
  end

  it "userはnilだったら無効" do
    @user.name = nil
    expect(@user).to_not be_valid 
  end

  it "userの名前が５１文字以上だったら無効" do
    @user.name = "a"*51
    expect(@user).to_not be_valid
  end

  it "userのemailが255文字以上だったら無効" do
    @user.email = "a"*255+"@email.com"
    expect(@user).to_not be_valid
  end

  it "emailはnilだったら無効" do
    @user.email = nil
    expect(@user).to_not be_valid 
  end

  it "emailで無効な文字列を拒否する" do
    valid_addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    valid_addresses.each do |invalid|
      expect(FactoryBot.build(:user, email: invalid)).to be_invalid
    end
  end

  it "同じユーザーは登録出来ない" do
    duplicate = @user.dup
    @user.save!
    duplicate.save!
    expect(duplicate).to_not be_valid
  end

  it "大文字、小文字のemailは同じになるか" do
    @user.email = "Yamamoto@Email.Com"
    @user.save!
    expect(@user.reload.email).to eq "yamamoto@email.com"
  end

  it "空白のパスワードは無効" do
    @user.password = @user.password_confirmation = " "*6
    expect(@user).to_not be_valid
  end

  it "6文字以下のパスワードは無効" do
    @user.password = @user.password_confirmation = "a"*5
    expect(@user).to_not be_valid
  end
end
