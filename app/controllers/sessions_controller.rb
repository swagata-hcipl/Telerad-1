class SessionsController < ApplicationController
include SessionsHelper
  def new
  end

  def create
    authorized_user = User.find_by(gateway: params[:session][:gateway])
    if authorized_user && authorized_user.authenticate(params[:session][:password])
      log_in authorized_user
      flash[:success] = "Wow Welcome again, you logged in as #{authorized_user.name}"
      redirect_to(:controller => 'users', :action => 'index')
    else
      flash[:danger] = "Invalid Username or Password"
      render "new"  
    end
  end



  def destroy
    log_out
    redirect_to root_path
  end
end
