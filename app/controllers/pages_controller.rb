class PagesController < ApplicationController
  
  def index
    if admin? || user?
      redirect_to :action => "home"
    else
      #redirect_to :action => "login"
      redirect_to :action => 'login'
    end
  end
  
  def home
    #@posts = Post.where((:post_type => "image") | (:post_type => "blog")).order("created_at DESC").limit(10)
    #@posts = Post.where("post_type = 'image' OR post_type = 'blog'")).order("created_at DESC").limit(10)
    @posts = Post.where(:post_type => "image").order("created_at DESC").limit(10) | Post.where(:post_type => "blog").order("created_at DESC").limit(10)
  end
  
  def pics
    @posts = Post.where(:post_type => "image").order("created_at DESC")
  end
  
  def blog
    @posts = Post.where(:post_type => "blog").order("created_at DESC")
    render 'home'
  end
  
  def videos
    @posts = Post.where(:post_type => "video").order("created_at DESC")
    render 'home'
  end
  
  def maps
    @posts = Post.where(:post_type => "map").order("created_at DESC")
    render 'home'
  end
  
  def poetry
    @posts = Post.where(:post_type => "poetry").order("created_at DESC")
    render 'home'
  end
  
  def home_admin
    @posts = Post.where(:post_type => "image").order("created_at DESC").limit(10)
  end
  
  def login
    puts "hello world"
  end

end
