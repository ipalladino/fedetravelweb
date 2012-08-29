class SessionsController < ApplicationController
  def new
  end
  
  def create
    if(User.find_by_email(params[:email]) == nil)
      redirect_to "/"
    else
      session[:password] = params[:password]
      flash[:notice] = "Successfully logged in"
      if(params[:previous_page] != nil && params[:previous_page] != "")
        redirect_to "/" + params[:previous_page]
      else
        redirect_to "/"
      end
    end
  end
  
  def destroy
      reset_session
      flash[:notice] = "Successfully logged out";
      redirect_to "/"
  end
  
end