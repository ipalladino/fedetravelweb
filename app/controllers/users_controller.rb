class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    if(!admin?) 
      redirect_to "/"
    else
      @users = User.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @users }
      end
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    if admin?
      @isadmin = admin?
      @user = User.find(params[:id])
    else
      redirect_to "/"
    end
  end

  # POST /users
  # POST /users.json
  def create
    init_amout = {:login_amount => 0, :active => true}
    params[:user] = params[:user].merge(init_amout)
    @user = User.new(params[:user])
    if @user.save
      redirect_to "/pages/login", :notice => 'User created successfully'
    else
      redirect_to "/pages/login", :notice => 'There was an error creating the user. Might already exist'
    end

    #respond_to do |format|
    #  if @user.save
        #format.html { redirect_to @user, :notice => 'User was successfully created.' }
        #format.json { render :json => @user, :status => :created, :location => @user }
    #  else
    #    format.html { render :action => "new" }
    #    format.json { render :json => @user.errors, :status => :unprocessable_entity }
    #  end
    #end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end
