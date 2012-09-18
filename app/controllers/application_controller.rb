class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :admin?
  helper_method :user?
  
  def admin?
      session[:password] == 'admin'
  end
  
  def user?
      session[:password] == 'freewill'
  end
end
