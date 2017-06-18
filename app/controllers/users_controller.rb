class UsersController < ApplicationController
  include CurrentCart
  before_action :set_cart
  #skip_before_action :authorize_user, only: [:new, :create]
  #skip_before_action :authorize_admin, only: [:new, :create]
  skip_before_action :authorize_user
  skip_before_action :authorize_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    authorize_admin
    @users = User.order(:name)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if session[:admin_id] == nil
      authorize_user
      if @user.id != session[:user_id]
        authorize_user
      end
    else
      authorize_admin
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if session[:admin_id] == nil
      authorize_user
      if @user.id != session[:user_id]
        authorize_user
      end
    else
      authorize_admin
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.user_type = 1

    respond_to do |format|
      if @user.save
        format.html { redirect_to shopper_url, notice: "User #{@user.name} was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if session[:admin_id] == nil
      authorize_user
      if @user.id != session[:user_id]
        authorize_user
      end
    else
      authorize_admin
    end

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User #{@user.name} was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if session[:admin_id] == nil
      authorize_user
      if @user.id != session[:user_id]
        authorize_user
      end
    else
      authorize_admin
    end
    @user.destroy
    respond_to do |format|
      format.html { redirect_to login_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
