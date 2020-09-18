class AddUserRefToChoices < ActiveRecord::Migration[5.2]
  def change
    add_reference :choices, :user, foreign_key: true
  end
end
