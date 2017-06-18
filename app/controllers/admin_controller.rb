class AdminController < ApplicationController
  include CurrentCart
  before_action :set_cart
  skip_before_action :authorize_user

  def index
    @total_orders = Order.count
  end
end
