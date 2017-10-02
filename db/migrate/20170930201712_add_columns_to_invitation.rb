class AddColumnsToInvitation < ActiveRecord::Migration[5.1]
  def change
  	add_column :invitations, :user_id, :integer
  	add_column :invitations, :recipient_id, :integer
  end
end