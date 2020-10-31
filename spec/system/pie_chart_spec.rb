require 'rails_helper'

RSpec.describe 'PieChart', js: true, type: :system do
  let(:user) { create(:user) }
  describe "詳細ページ、円グラフの表示テスト" do
    before do
      log_in_as(user)
      click_link "Judgement"
      fill_in "コメントを記入して下さい", with: "テスト投稿"
      fill_in "Choiceボタン名を記入して下さい", with: "テストボタン"
      click_button "Judgement?"
      click_link "yamamoto", match: :first
    end
    it "最初の投稿時、円グラフの表示は無く、投票数は0。" do
      expect(page).to have_content '投票はありません'
      expect(page).to have_selector 'td', text: '0'
    end

    it "choiceボタンを押すと円グラフが表示されて、投票数が増える。" do
      click_link "テストボタン"
      expect(page).to_not have_content '投票はありません'
      expect(page).to have_selector 'td', text: '1'
    end

    it "再度choiceボタンを押すと、投票がキャンセルされる。" do
      click_link "テストボタン"
      expect(page).to_not have_content '投票はありません'
      expect(page).to have_selector 'td', text: '1'
      click_link "テストボタン"
      expect(page).to have_content '投票はありません'
    end
  end
end
