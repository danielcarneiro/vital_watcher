class HeartRateTypesController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user,  :except => :index

  # GET /heart_rate_types
  # GET /heart_rate_types.json
  def index
    @heart_rate_types = HeartRateType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @heart_rate_types }
    end
  end

  # GET /heart_rate_types/1
  # GET /heart_rate_types/1.json
  def show
    @heart_rate_type = HeartRateType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @heart_rate_type }
    end
  end

  # GET /heart_rate_types/new
  # GET /heart_rate_types/new.json
  def new
    @heart_rate_type = HeartRateType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @heart_rate_type }
    end
  end

  # GET /heart_rate_types/1/edit
  def edit
    @heart_rate_type = HeartRateType.find(params[:id])
  end

  # POST /heart_rate_types
  # POST /heart_rate_types.json
  def create
    @heart_rate_type = HeartRateType.new(params[:heart_rate_type])

    respond_to do |format|
      if @heart_rate_type.save
        format.html { redirect_to @heart_rate_type, notice: 'Heart rate type was successfully created.' }
        format.json { render json: @heart_rate_type, status: :created, location: @heart_rate_type }
      else
        format.html { render action: "new" }
        format.json { render json: @heart_rate_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /heart_rate_types/1
  # PUT /heart_rate_types/1.json
  def update
    @heart_rate_type = HeartRateType.find(params[:id])

    respond_to do |format|
      if @heart_rate_type.update_attributes(params[:heart_rate_type])
        format.html { redirect_to @heart_rate_type, notice: 'Heart rate type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @heart_rate_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heart_rate_types/1
  # DELETE /heart_rate_types/1.json
  def destroy
    @heart_rate_type = HeartRateType.find(params[:id])
    @heart_rate_type.destroy

    respond_to do |format|
      format.html { redirect_to heart_rate_types_url }
      format.json { head :ok }
    end
  end

  private
  
    
end
