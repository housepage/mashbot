class PhotosController < ApplicationController

  include PhotosHelper

  # GET /photos
  # GET /photos.xml
  def index
    @photos = Photo.all
    @campaign = Campaign.find params[:campaign_id]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = Photo.find(params[:id])
    @campaign = Campaign.find params[:campaign_id]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.xml
  def new
    @photo = Photo.new
    @campaign = Campaign.find params[:campaign_id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
    @campaign = Campaign.find params[:campaign_id]
  end

  # POST /photos
  # POST /photos.xml
  def create
    @photo = Photo.new(params[:photo])
    @campaign = Campaign.find params[:campaign_id]
    @photo.creator = current_user
    @photo.campaign = @campaign
    @photo.go_live = "#{params[:go_live_date]} #{params[:go_live_time]}"
    @photo.optional_fields = params[:optional_fields]
    @photo.permissions = params[:permissions]
    respond_to do |format|
      if @photo.save
        flash[:notice] = 'Photo was successfully created.'
        format.html { redirect_to(@photo) }
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.xml
  def update
    @photo = Photo.find(params[:id])
    @campaign = Campaign.find params[:campaign_id]
    @photo.creator = current_user
    @photo.campaign = @campaign
    @photo.go_live = "#{params[:go_live_date]} #{params[:go_live_time]}"

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        flash[:notice] = 'Photo was successfully updated.'
        format.html { redirect_to(@photo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @campaign = Campaign.find params[:campaign_id]
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to(photos_url) }
      format.xml  { head :ok }
    end
  end
end
