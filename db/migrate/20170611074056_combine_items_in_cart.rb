class CombineItemsInCart < ActiveRecord::Migration[5.1]
  def up
    Cart.all.each do |cart|
      sums = cart.lineitems.group(:product_id).sum(:quantity)
      sums.each do |product_id, quantity|
        if quantity > 1
          cart.lineitems.where(product_id: product_id).delete_all
          item = cart.lineitems.build(product_id: product_id)
          item.quantity = quantity
        else
          item = cart.lineitems.where(product_id: product_id).first
          item.quantity = 1
        end
        item.save!
      end
    end
  end
end
