class AddVoteNameToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :vote_1, :text
    add_column :microposts, :vote_2, :text
    add_column :microposts, :vote_3, :text
    add_column :microposts, :vote_4, :text
  end
end
