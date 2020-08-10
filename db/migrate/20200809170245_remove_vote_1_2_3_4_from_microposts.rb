class RemoveVote1234FromMicroposts < ActiveRecord::Migration[5.2]
  def change
    remove_column :microposts, :vote_1, :text
    remove_column :microposts, :vote_2, :text
    remove_column :microposts, :vote_3, :text
    remove_column :microposts, :vote_4, :text
  end
end
