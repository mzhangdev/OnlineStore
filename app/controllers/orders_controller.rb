class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart
  skip_before_action :authorize_user
  skip_before_action :authorize_admin
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    if session[:admin_id] != nil
      @orders = Order.all
    else
      if session[:user_id] == nil
        authorize_user
      end
      @orders = Order.where(user_id: session[:user_id])
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    if session[:admin_id] == nil
      authorize_user
    else
      authorize_admin
    end
  end

  # GET /orders/new
  def new
    if @cart.lineitems.empty?
      redirect_to shopper_url, notice: "Your cart is empty"
      return
    end
    if session[:admin_id] == nil
      authorize_user
    else
      authorize_admin
    end

    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    if session[:admin_id] == nil
      authorize_admin
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    if session[:admin_id] == nil
      authorize_user
    end
    @order = Order.new(order_params)
    @order.user_id = session[:user_id]
    @order.total_price = @cart.total_price

    respond_to do |format|
      if @order.save
        #Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        @order.add_items_from_cart(@cart, @order.id)
        format.html { redirect_to shopper_url, notice: 'Thank you for your order.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    if session[:admin_id] == nil
      authorize_admin
    end
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    if session[:admin_id] == nil
      authorize_admin
    end
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :paytype)
    end
end
