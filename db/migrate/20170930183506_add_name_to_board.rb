class AddNameToBoard < ActiveRecord::Migration[5.1]
  def change
  	add_column :boards, :name, :string
  end
end
