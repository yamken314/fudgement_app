require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user, name: "yamamoto", email: "yamamoto@email.com", password: "yamamoto") }

  it "userは有効" do
    expect(user).to be_valid
  end

  it "userはnilだったら無効" do
    user.name = nil
    expect(user).to_not be_valid 
  end

  it "userの名前が５1文字以上だったら無効" do
    user.name = "a" * 51
    expect(user).to_not be_valid
  end

  it "userの名前が50文字だったら有効" do
    user.name = "a" * 50
    expect(user).to be_valid
  end

  it "userのemailが255文字以上だったら無効" do
    user.email = "a" * 255 + "@email.com"
    expect(user).to_not be_valid
  end

  it "userのemailが255文字以内だったら有効" do
    user.email = "a" * 245 + "@email.com"
    expect(user).to be_valid
  end

  it "emailはnilだったら無効" do
    user.email = nil
    expect(user).to_not be_valid 
  end

  it "emailで無効な文字列を拒否する" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. 
                          foo@bar_baz.com foo@bar+baz.com ]
    invalid_addresses.each do |invalid_address|
      user = FactoryBot.build(:user, email: invalid_addresses)
      user.valid?
      expect(user.errors.messages[:email]).to include("は不正な値です")
    end
  end
  
  it "同じユーザーは登録出来ない" do
    duplicate = build(:user)
    user.save
    duplicate.save
    duplicate.valid?
    expect(duplicate).to_not be_valid
  end

  it "大文字、小文字のemailは同じになるか" do
    user.email = "Yamamoto@Email.Com"
    user.save!
    expect(user.reload.email).to eq "yamamoto@email.com"
  end

  it "空白のパスワードは無効" do
    user = build(:user, password: '')
    user.save(context: :password)
    expect(user.errors[:password]).to include('を入力してください')
  end

  it "6文字以下のパスワードは無効" do
    user = build(:user, password: 'a' * 5)
    user.save(context: :password)
    expect(user.errors[:password]).to include('は6文字以上で入力してください')
  end

  it "6文字以上のパスワードは有効" do
    user = build(:user, password: 'a' * 6)
    user.save(context: :password)
    expect(user).to be_valid
  end

  it "authenticated?実行時,ユーザーのダイジェストがnilならfalseを返す" do
    expect(user.authenticated?('')).to eq false
  end
end
