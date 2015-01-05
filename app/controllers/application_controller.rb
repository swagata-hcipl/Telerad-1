class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_cache_buster

<<<<<<< HEAD
  include SessionsHelper
  
=======
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
>>>>>>> 0b3fcdc33e803c42f74b6b39fadd0424dd6a3e03
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

