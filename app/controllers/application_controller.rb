class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :admin?
  helper_method :user?
  
  def admin?
      session[:password] == 'andrew_admin'
  end
  
  def user?
      session[:password] == 'register'
  end
end
