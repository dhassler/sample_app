class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  
  def deny_access
    redirect_to login_path, :notice => "Please sign in to access this page"
  end
  helper_method :deny_access
end
