class AddUniquenessIndexToTeams < ActiveRecord::Migration[5.1]
  def change
  	add_index :teams, [:user_id, :board_id], unique: true
  end
end
