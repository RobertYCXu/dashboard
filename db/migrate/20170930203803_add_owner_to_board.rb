class AddOwnerToBoard < ActiveRecord::Migration[5.1]
  def change
  	add_column :boards, :owner, :integer
  end
end
