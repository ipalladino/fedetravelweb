class PostsController < ApplicationController
  @@BUCKET = "travelweb-assets"
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
      format.html
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
    puts "Post title:" + params[:post][:title]
    if(params[:post_type] != "poetry")
      filename = timestamp + "_" + sanitize_filename(params[:upload]['datafile'].original_filename)
      puts "Saving" + filename
      AWS::S3::S3Object.store(filename, params[:upload]['datafile'].read, @@BUCKET, :access => :public_read)
      url = AWS::S3::S3Object.url_for(filename, @@BUCKET, :authenticated => false)
    else
      url = ''
    end
    
    @post = Post.new(
      :title => params[:post][:title], 
      :content => params[:post][:content], 
      :post_type => params[:post_type], 
      :file => url,
      :active => params[:post][:active]
    )
    
    #data_file = DataFile.save(params[:upload], timestamp)

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
    timestamp = Time.now.utc.iso8601.gsub(/\W/, '')
    if(params[:post_type] != "poetry")
      if(!params[:upload].empty?)
        filename = File.basename(@post.file)
        AWS::S3::S3Object.delete(filename, @@BUCKET)
        filename = timestamp + "_" + sanitize_filename(params[:upload]['datafile'].original_filename)
        puts "Saving" + filename
        AWS::S3::S3Object.store(filename, params[:upload]['datafile'].read, @@BUCKET, :access => :public_read)
        url = AWS::S3::S3Object.url_for(filename, @@BUCKET, :authenticated => false)
        @post.file = url
      end
    end
    
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
    filename = File.basename(@post.file)
    if(@post.post_type != "poetry")
      AWS::S3::S3Object.delete(filename, @@BUCKET)
    end
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
