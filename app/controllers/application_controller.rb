class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper
  
  protected
    def authenticate_user
      if session[:user_id]
        @current_user = User.find session[:user_id]
      else
        redirect_to(:controller => 'sessions', :action => 'login')
      end
    end

    def save_login_state
      if session[:user_id]
        redirect_to(:controller => 'users', :action => 'index')
        return false
      else
        return true
      end
    end 
end
