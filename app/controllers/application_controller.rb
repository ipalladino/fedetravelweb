class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def admin?
      session[:password] == 'admin'
  end
  
  def user?
    session[:password] == 'freewill'
  end
end
