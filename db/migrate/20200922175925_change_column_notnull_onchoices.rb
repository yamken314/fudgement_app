class ChangeColumnNotnullOnchoices < ActiveRecord::Migration[5.2]
  def change
    change_column_null :choices, :name, false
  end
end
