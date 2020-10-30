require 'rails_helper'

RSpec.describe 'Microposts', js: true, type: :system do
  let(:user) { create(:user) }
  it "投稿成功する" do
    log_in_as(user)
    click_link "Judgement"
    fill_in "コメントを記入して下さい", with: "test"
    fill_in "Choiceボタン名を記入して下さい", with: "choice"
    click_button "Judgement?"
    expect(page).to have_content "コメントを作成しました"
  end

  describe "投稿失敗時のエラー表示" do
    it "Contentを入力して下さい。" do
      log_in_as(user)
      click_link "Judgement"
      fill_in "コメントを記入して下さい", with: ""
      fill_in "Choiceボタン名を記入して下さい", with: "choice"
      click_button "Judgement?"
      expect(page).to have_content "Contentを入力してください"
    end

    it "Choices nameを入力してください。" do
      log_in_as(user)
      click_link "Judgement"
      fill_in "コメントを記入して下さい", with: ""
      fill_in "Choiceボタン名を記入して下さい", with: ""
      click_button "Judgement?"
      expect(page).to have_content "Choices nameを入力してください"
    end
  end

  it "choiceボタン入力フォームを追加する。" do
    log_in_as(user)
    click_link "Judgement"
    click_link "ボタンを追加"
    expect(all('.number').size).to eq(2)
  end
end
