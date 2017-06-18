class AlterQuantityToLineitems < ActiveRecord::Migration[5.1]
  def change
    change_column :lineitems, :quantity, :integer, default: 1
  end
end
