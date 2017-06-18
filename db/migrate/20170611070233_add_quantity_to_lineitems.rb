class AddQuantityToLineitems < ActiveRecord::Migration[5.1]
  def change
    add_column :lineitems, :quantity, :integer
  end
end
