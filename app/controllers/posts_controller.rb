class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    if admin?
      @posts = Post.find(:all, :order => "created_at DESC")

      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @posts }
      end
    else
      redirect_to "/"
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    
    respond_to do |format|
      if(user?) 
        format.html {render :template => 'posts/show_guest'}
      elsif(admin?)
        format.html {render :template => 'posts/show'}
      end
      format.json { render :json => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    if admin?
      @post = Post.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render :json => @post }
      end
    else
      redirect_to "/"
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    timestamp = Time.now.utc.iso8601.gsub(/\W/, '')
    filename = sanitize_filename(params[:upload]['datafile'].original_filename)
    puts filename
    puts params[:post][:title]
    
    @post = Post.new(
      :title => params[:post][:title], 
      :content => params[:post][:content], 
      :post_type => params[:post_type], 
      :file => timestamp + "_" + filename,
      :active => params[:post][:active]
    )

    data_file = DataFile.save(params[:upload], timestamp)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, :notice => 'Post was successfully created.' }
        format.json { render :json => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, :notice => 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end
  def sanitize_filename(file_name)
    # get only the filename, not the whole path (from IE)
    just_filename = File.basename(file_name) 
    # replace all none alphanumeric, underscore or perioids
    # with underscore
    just_filename.sub(/[^\w\.\-]/,'_') 
  end
end


class DataFile < ActiveRecord::Base
  def self.save(upload, timestamp)
    name =  sanitize_filename(upload['datafile'].original_filename)
    directory = "public/data"
    # create the file path
    path = File.join(directory, timestamp + "_" + name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
  end
  
  def self.sanitize_filename(file_name)
    # get only the filename, not the whole path (from IE)
    just_filename = File.basename(file_name) 
    # replace all none alphanumeric, underscore or perioids
    # with underscore
    just_filename.sub(/[^\w\.\-]/,'_') 
  end
  
end
