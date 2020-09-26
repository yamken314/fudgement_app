class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :introduction, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :profiles, [:user_id, :introduction], unique: true
  end
end
