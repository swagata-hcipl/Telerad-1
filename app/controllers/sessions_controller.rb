class SessionsController < ApplicationController

  def new
  end

  def create
    authorized_user = User.find_by(gateway: params[:session][:gateway])
    if authorized_user && authorized_user.authenticate(params[:session][:password])
      log_in authorized_user
      flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.name}"
      redirect_to(:controller => 'users', :action => 'index')
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "new"  
    end
  end



  def destroy
    log_out
    redirect_to root_path
  end
end
