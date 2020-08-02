class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.bigint :choice, foreign_key: true
      t.bigint :user, foreign_key: true
      t.integer :user_id
      t.integer :choice_id
      t.timestamps

    end
    add_index :votes, [:user_id, :choice_id], unique: true
  end
end
