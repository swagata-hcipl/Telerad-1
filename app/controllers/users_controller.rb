class UsersController < ApplicationController

  before_filter :authenticate_user

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You signed up successfully"
      flash[:color]= "valid"
<<<<<<< HEAD
      log_in @user
=======
>>>>>>> 0b3fcdc33e803c42f74b6b39fadd0424dd6a3e03
      redirect_to(:controller => 'users', :action => 'index')
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
      render "new"
    end

  end

  def update
  end

  def edit
  end

  def index
    @patients = current_user.patients
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:name, :gateway, :gateway_type, :password, :password_confirmation)
  end
end
