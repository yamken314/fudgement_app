class CreateChoices < ActiveRecord::Migration[5.2]
  def change
    create_table :choices do |t|
      t.text :name
      t.references :micropost, foreign_key: true

      t.timestamps
    end
  end
end
