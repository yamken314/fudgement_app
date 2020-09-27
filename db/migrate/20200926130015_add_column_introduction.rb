class AddColumnIntroduction < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :introduction, :string
  end
  
  def down
    remove_column :users, :integration, :string
  end
end
