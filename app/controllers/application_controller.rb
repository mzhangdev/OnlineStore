class ApplicationController < ActionController::Base
  before_action :authorize_admin, except: :not_found
  before_action :authorize_user, except: :not_found
  protect_from_forgery with: :exception

  def authorize_admin
    unless (user = User.find_by(id: session[:admin_id])) && (user.user_type == 0)
      redirect_to login_url, notice: "Please log in as an admin"
    end
  end

  def authorize_user
    unless (user = User.find_by(id: session[:user_id])) && (user.user_type == 1)
      redirect_to login_url, notice: "Please log in"
    end
  end

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render file: "public/404.html", status: :not_found, layout: false
  end
end
