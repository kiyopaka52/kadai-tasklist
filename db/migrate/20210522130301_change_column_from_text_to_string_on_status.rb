class ChangeColumnFromTextToStringOnStatus < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :status, :string
  end
  
  def down
    change_column :tasks, :status, :text
  end
end
