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
    @posts = Post.find(:all, :limit => 10)
  end
  
  def pics
    @posts = Post.where(:post_type => "image")
  end
  
  def home_admin
    @posts = Post.find(:all, :limit => 10)
  end
  
  def login
    puts "hello world"
  end

end