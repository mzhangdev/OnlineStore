class AccessController < ApplicationController
  skip_before_action :authorize_admin
  skip_before_action :authorize_user
  include CurrentCart
  before_action :set_cart

  def new
    if session[:admin_id]
      redirect_to admin_url, notice: "already logged on"
      return
    end
    if session[:user_id]
      redirect_to shopper_url, notice: "already logged on"
      return
    end
  end

  def create
    user = User.find_by(name: params[:name])
    if user and user.authenticate(params[:password])
      if user.user_type == 0
        session[:admin_id] = user.id
        redirect_to admin_url
      else
        session[:user_id] = user.id
        redirect_to shopper_url
      end
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:admin_id] = nil
    redirect_to shopper_url, notice: "Logged out"
  end
end
