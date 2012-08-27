class PagesController < ApplicationController
  
  def index
    if admin?
      redirect_to :action => "home_admin"
    elsif user?
      redirect_to :action => "home"
    else
      #redirect_to :action => "login"
      redirect_to :action => 'login'
    end
  end
  
  def home
    
  end
  
  def home_admin
  end
  
  def login
    puts "hello world"
  end

end
