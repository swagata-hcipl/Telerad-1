class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_cache_buster


  include SessionsHelper
  

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
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

