class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email].downcase)
    
    if(user == nil)
      redirect_to "/"
    else
      amount = user[:login_amount]
      amount = Integer(amount) + 1
      user.update_attributes(:login_amount => amount)
      session[:password] = params[:password]
      flash[:notice] = "Successfully logged in"
      if(params[:previous_page] != nil && params[:previous_page] != "")
        redirect_to "/" + params[:previous_page]
      else
        redirect_to "/"
      end
    end
  end
  
  def self.find_by_email(email)
    User.find(:all, :conditions => ["email = lower(?)", email]) 
  end
  
  def destroy
      reset_session
      flash[:notice] = "Successfully logged out";
      redirect_to "/"
  end
  
end