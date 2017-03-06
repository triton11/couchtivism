class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]

  # GET /campaigns
  # GET /campaigns.json
  def index
    @campaigns = Campaign.search(params[:search])
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
    @campaign = Campaign.find_by(id: params[:id])
    @daily = @campaign.goals.where(time: 1)
    @daily.each do |inst|
      if (!(inst.calculate))
        @daily.remove(inst)
      end
    end
    @weekly = @campaign.goals.where(time: 7)
    @weekly.each do |inst|
      if (!(inst.calculate))
        @weekly.remove(inst)
      end
    end
    @monthly = @campaign.goals.where(time: 31)
    @monthly.each do |inst|
      if (!(inst.calculate))
        @monthly.remove(inst)
      end
    end
    @yearly = @campaign.goals.where(time: 360)
    @yearly.each do |inst|
      if (!(inst.calculate))
        @yearly.remove(inst)
      end
    end
    @points = 0
    if (logged_in?)
      current_user.goals.where(campaign_id: @campaign.id).each do |item|
        @points += item.points
      end
    end
  end

  def join
    @campaign = Campaign.find_by(id: params[:campaign])
    @campaign.users << current_user
    current_user.campaigns << @campaign
    current_user.save
    respond_to do |format|
      if @campaign.save
        format.html { redirect_to @campaign, notice: 'Campaign was successfully joined.' }
        format.json { render :show, status: :created, location: @campaign }
      else
        format.html { render :new }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  def complete
    @campaign = Campaign.find_by(id: params[:campaign])
    @goal = Goal.find_by(id: params[:goal])
    current_user.goals << @goal
    respond_to do |format|
      if current_user.save
        format.html { redirect_to @campaign, notice: 'Complete' }
        format.json { render :show, status: :created, location: @campaign }
      else
        format.html { render :new }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end



  # GET /campaigns/new
  def new
    @campaign = Campaign.new
  end

  # GET /campaigns/1/edit
  def edit
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    @campaign = Campaign.new(campaign_params)
    @mod = Mod.create(:email => current_user.email)
    @campaign.mods << @mod
    current_user.mods << @mod

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to @campaign, notice: 'Campaign was successfully created.' }
        format.json { render :show, status: :created, location: @campaign }
      else
        format.html { render :new }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to @campaign, notice: 'Campaign was successfully updated.' }
        format.json { render :show, status: :ok, location: @campaign }
      else
        format.html { render :edit }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit(:title, :description)
    end
end
