class MapLocationController < ApplicationController
  # GET /maplocation
  # GET /maplocation.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @maplocation }
    end
  end
  
  def manage
    @maplocations = MapLocation.find(:all)
    render :manage
  end
  
  def list
    @maps = MapLocation.find(:all)
    render :json => @maps
  end 

  # GET /maplocation/1
  # GET /maplocation/1.json
  def show
    @maplocation = MapLocation.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @maplocation }
    end
  end

  # GET /maplocation/new
  # GET /maplocation/new.json
  def new
    if admin?
      @maplocation = MapLocation.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render :json => @maplocation }
      end
    else
      redirect_to "/"
    end
  end

  # GET /maplocation/1/edit
  def edit
    @maplocation = MapLocation.find(params[:id])
  end

  # POST /maplocation
  # POST /maplocation.json
  def create
    #if admin?
      @maplocation = MapLocation.new(
        :xval => params[:xval], 
        :yval => params[:yval],
        :title => params[:title],
        :content => params[:content]
      )
      @maplocation.save
      redirect_to "/map_location"

    #else
    #  redirect_to "/"
    #end
  end
  
  # PUT /maplocation/1
  # PUT /maplocation/1.json
  def update
    @maplocation = MapLocation.find(params[:id])

    respond_to do |format|
      if @maplocation.update_attributes(params[:user])
        format.html { redirect_to @maplocation, :notice => 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @maplocation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /maplocation/1
  # DELETE /maplocation/1.json
  def destroy
    @maplocation = MapLocation.find(params[:id])
    @maplocation.destroy
    respond_to do |format|
      format.html { redirect_to '/map_location/manage' }
      format.json { head :ok }
    end
  end
  

end
