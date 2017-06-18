class RemoveUserFromLineitems < ActiveRecord::Migration[5.1]
  def change
    remove_column :lineitems, :user_id, :integer
  end
end
