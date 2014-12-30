class SessionsController < ApplicationController

  before_filter :authenticate_user, :except => [:login, :login_attempt]
  before_filter :save_login_state, :only => [:login, :login_attempt]

  def login
  end

  def login_attempt
    authorized_user = User.find_by(gateway:params[:gateway]).authenticate(params[:password])
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.name}"
      redirect_to(:controller => 'users', :action => 'index')
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"  
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :action => 'login'
  end
end