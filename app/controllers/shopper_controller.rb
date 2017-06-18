class ShopperController < ApplicationController
  skip_before_action :authorize_user
  skip_before_action :authorize_admin

  include CurrentCart
  before_action :set_cart

  def index
    search_query = params[:q]
    minp = params[:minp].to_f
    maxp = params[:maxp].to_f
    puts minp
    puts maxp

    if search_query
      @products = Product.where("name like ? or description like ?", '%' + search_query + '%', '%' + search_query + '%').order(:name)
    else
      @products = Product.order(:name)
    end

    if maxp > 0
      puts "in maxp"
      @products = @products.find_all{|item| item.price < maxp }
    end

    if minp > 0
      puts "in minp"
      @products = @products.find_all{|item| item.price > minp }
    end

  end
end
