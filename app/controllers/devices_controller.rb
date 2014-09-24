class DevicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_device, only: [:show, :edit, :update, :destroy]
  before_action :set_device_by_id, only: [:streams, :delete_streams]
  # GET /devices
  # GET /devices.json
  def index
    @devices = Device.all_from_user(current_user)
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
  end

  # GET /devices/new
  def new
    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)
    @device.user = current_user
    
    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render :show, status: :created, location: @device }
      else
        format.html { render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { render :show, status: :ok, location: @device }
      else
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    if @device.user.id == current_user.id
      @device.destroy
      respond_to do |format|
        format.html { redirect_to devices_url, notice: 'Device was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      render status: :bad_request
    end
  end

  def streams
    respond_to do |format|  
      format.json { render json: @device.streams, status: :ok }
    end
  end

  def delete_streams
    @device.streams.delete_all
    respond_to do |format|
      format.html { redirect_to devices_url, notice: 'All Streams have been deleted.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    def set_device_by_id
      @device = Device.find(params[:device_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:key, :name, :description)
    end
end
