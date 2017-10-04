class AllowNullBoardToNotes < ActiveRecord::Migration[5.1]
  def change
  	change_column :notes, :board_id, :integer, null: true
  end
end
