require 'rails_helper'

RSpec.describe 'ActiveStorage', js: true, type: :system do
  let(:user) { create(:user) }
  before do
    log_in_as(user)
  end
  it "画像を投稿する" do
    post_content
    attach_file("micropost[image]", 'spec/support/assets/test_image.jpg', visible: false)
    click_button "Judgement?"
    expect(page).to have_selector("img[src$='test_image.jpg']")
  end

  it "画像投稿時のエラー表示" do
    post_content
    attach_file("micropost[image]", 'spec/support/assets/10megabytes.jpg', visible: false)
    click_button "Judgement?"
    expect(page).to have_content 'ファイルのサイズが大きすぎます(10MB以内)'
  end

  it "avatar画像を登録する" do
    click_link "My page"
    click_on "編集"
    attach_file("user[avatar]", 'spec/support/assets/test_image.jpg', visible: false)
    click_on "更新"
    expect(page).to have_selector("img[src$='test_image.jpg']")
  end

  it "avatar画像登録時のエラー表示" do
    click_link "My page"
    click_on "編集"
    attach_file("user[avatar]", 'spec/support/assets/10megabytes.jpg', visible: false)
    click_on "更新"
    expect(page).to have_content 'ファイルのサイズが大きすぎます(10MB以内)'
  end

  it "プロフィール画像を登録する" do
    click_link "My page"
    click_on "編集"
    attach_file("user[profile_image]", 'spec/support/assets/test_image.jpg', visible: false)
    click_on "更新"
    expect(page).to have_selector("img[src$='test_image.jpg']")
  end

  it "プロフィール画像登録時のエラー表示" do
    click_link "My page"
    click_on "編集"
    attach_file("user[profile_image]", 'spec/support/assets/10megabytes.jpg', visible: false)
    click_on "更新"
    expect(page).to have_content 'ファイルのサイズが大きすぎます(10MB以内)'
  end
end
