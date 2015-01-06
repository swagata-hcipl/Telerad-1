class UsersController < ApplicationController

  before_filter :authenticate_user, except: [:new, :create]

  def index
    @patients = current_user.patients.uniq
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "You signed up successfully"
      log_in @user
      redirect_to(:controller => 'users', :action => 'index')
    else
      flash[:success] = "Form is invalid"
      render "new"
    end

  end

  def update
  end

  def edit
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:name, :gateway, :gateway_type, :password, :password_confirmation)
  end
end
