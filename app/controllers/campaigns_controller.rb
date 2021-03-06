class CampaignsController < ApplicationController
  before_filter :require_user
  
  # GET /campaigns
  # GET /campaigns.xml
  def index
    @campaigns = Campaign.all
    @campaigns.sort {|a, b| a.start_date <=> b.start_date}
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @campaigns }
    end
  end

  # GET /campaigns/1
  # GET /campaigns/1.xml
  def show
    @campaign = Campaign.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @campaign }
      format.json { render :json => @campaign }
    end
  end

  # GET /campaigns/new
  # GET /campaigns/new.xml
  def new
    @campaign = Campaign.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @campaign }
    end
  end

  # GET /campaigns/1/edit
  def edit
    @campaign = Campaign.find(params[:id])
    @campaign.start_date = Date.parse(@campaign.start_date).strftime('%m/%d/%Y') if @campaign.start_date
    @campaign.end_date = Date.parse(@campaign.end_date).strftime('%m/%d/%Y') if @campaign.end_date
  end

  # POST /campaigns
  # POST /campaigns.xml
  def create
    @campaign = Campaign.new(params[:campaign])

    respond_to do |format|
      if @campaign.save
        flash[:notice] = 'Campaign was successfully created.'
        format.html { redirect_to(@campaign) }
        format.xml  { render :xml => @campaign, :status => :created, :location => @campaign }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @campaign.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /campaigns/1
  # PUT /campaigns/1.xml
  def update
    @campaign = Campaign.find(params[:id])
    respond_to do |format|
      if @campaign.update_attributes(params[:campaign])
        message = 'Campaign was successfully updated.'
        flash[:notice] = message
        if request.xhr?
          render :json => {:success => true, :message => message }
          return
        end
        format.html { redirect_to(@campaign) }
        format.xml  { head :ok }
      else
        if request.xhr?
          render :json => {:success => false, :message => @campaign.errors.full_messages.join(' ')}
          return
        end
        format.html { render :action => "edit" }
        format.xml  { render :xml => @campaign.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  # DELETE /campaigns/1
  # DELETE /campaigns/1.xml
  def destroy
    @campaign = Campaign.find(params[:id])
    @campaign.destroy

    respond_to do |format|
      format.html { redirect_to(campaigns_url) }
      format.xml  { head :ok }
    end
  end

  def scheduled
    campaigns = Campaign.find(:all)
    @scheduled_campaigns = []
    campaigns.each do |campaign|
      if true #!campaign.start_date.nil? and !campaign.start_date == ''
        @scheduled_campaigns.push campaign.to_fullcalendar_event.to_hash
      end
    end
    render :json => @scheduled_campaigns
  end
  
  def content
    @campaign = Campaign.find(params[:id])
  end

end
