class AddColumnsToNotes < ActiveRecord::Migration[5.1]
  def change
  	add_column :notes, :user_id, :integer
  	add_column :notes, :board_id, :integer
  end
end
