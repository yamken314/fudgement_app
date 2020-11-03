require "rails_helper"

RSpec.describe "Vote", type: :request do
  let(:choice) { create(:choice) }
  let(:other_user) { create(:other_user) }
  describe "choiceボタンを押すと" do
    it "vote数が増える" do
      sign_in_as(other_user)
      expect do
        post choice_vote_path(choice.id), xhr: true
      end.to change(Vote, :count).by(1)
    end

    it "vote数が減る" do
      sign_in_as(other_user)
      post choice_vote_path(choice.id), xhr: true
      expect do
        delete choice_vote_path(choice.id), xhr: true
      end.to change(Vote, :count).by(-1)
    end
  end
end
