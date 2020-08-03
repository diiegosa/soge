class ServiceStationsController < ApplicationController
  #before_action :set_event, only: [:index]
  before_action :set_service_station, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:create, :destroy, :update]

  # GET /service_stations
  # GET /service_stations.json
  def index
    @q = ServiceStation.ransack(params[:q])
    @service_stations = @q.result(distinct: true)
  end

  # GET /service_stations/1
  # GET /service_stations/1.json
  def show
  end
  
  # GET /service_stations/new
  def new
    @service_station = ServiceStation.new
  end

  # GET /service_stations/1/edit
  def edit
  end

  # POST /service_stations
  # POST /service_stations.json
  def create
    @service_station = ServiceStation.new(service_station_params)
    
    respond_to do |format|
      if @service_station.create(service_station_params)
        format.html { redirect_to @service_station, notice: translate_message(:created) }
        format.json { render :show, status: :created, location: @service_station }
      else
        format.html { render :new }
        format.json { render json: @service_station.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /service_stations/1
  # PATCH/PUT /service_stations/1.json
  def update
    respond_to do |format|
      @service_station.service_station_vehicle_type if service_station_params[:service_station_type_id].to_i != ServiceStationType.get_vehicle_id && !@service_station.service_station_vehicle_type.nil?
      if @service_station.update(service_station_params)
        format.html { redirect_to @service_station, notice: translate_message(:updated) }
        format.json { render :show, status: :ok, location: @service_station }
      else
        format.html { render :edit }
        format.json { render json: @service_station.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /service_stations/1
  # DELETE /service_stations/1.json
  def destroy
    @service_station.destroy
    
    respond_to do |format|
      format.html { redirect_to service_stations_url, notice: translate_message(:destroyed) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_station
      @service_station = ServiceStation.find(params[:id])
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_station_params
      params.require(:service_station).permit(:description, :acronym, :militaries_quantity, :work_shift, :event_id, :command_post_id, :service_station_type_id,
        service_station_work_shifts_attributes:[
          :id, :militaries_quantity, :work_shift
        ],
        service_station_vehicle_type_attributes:[
          :vehicle_type_id
        ]
      )
    end
end
