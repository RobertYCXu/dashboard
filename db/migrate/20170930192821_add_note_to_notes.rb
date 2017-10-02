class AddNoteToNotes < ActiveRecord::Migration[5.1]
  def change
  	add_column :notes, :note, :string
  end
end
