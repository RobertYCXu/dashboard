class AllowNullUserToNotes < ActiveRecord::Migration[5.1]
  def change
  	change_column :notes, :user_id, :integer, null: true
  end
end
