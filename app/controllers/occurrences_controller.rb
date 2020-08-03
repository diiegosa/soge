class OccurrencesController < ApplicationController
  before_action :set_occurrence, only: [:show, :edit, :update, :destroy]
  before_action :set_service_station, only: [:index, :edit, :new, :destroy, :update, :create] #:set_occurrence_interval
  before_action :set_occurrence_natures, only: [:new, :create, :edit, :update]
  before_action :set_occurrence_interval, only: [:new, :edit, :create]
  before_action :get_route, only: [:new, :edit, :create]

  # GET /occurrences
  # GET /occurrences.json
  def index
    @q = Occurrence.by_service_station(@service_station).ransack(params[:q])
    @occurrences = @q.result(distinct: true)
    
    #@occurrences = @q.result.includes(:occurrence_nature).to_a.uniq
    # if params.include?(:event_id)
    #   interval = Occurrence.get_interval_list(@event)
    #   @occurrence_nature_with_intervals = OccurrenceNature.get_all_by_type_and_interval(interval)
    #   Occurrence.get_to_index_view(@occurrence_nature_with_intervals, @event) 
    # end
  end

  # GET /occurrences/1
  # GET /occurrences/1.json
  def show
  end

  # GET /occurrences/new
  def new
    @occurrence = Occurrence.new
    redirect_to event_path(@service_station.event_id), notice: 'Este evento não possui postos de atendimento cadastrados.' if @service_station.event.service_stations.first.nil?
  end

  # GET /occurrences/1/edit
  def edit
  end

  # POST /occurrences
  # POST /occurrences.json
  def create
    @occurrence = Occurrence.new(occurrence_params)
    respond_to do |format|
      if @occurrence.save
        format.html { redirect_to get_route(:new), notice: translate_message(:created) }
        format.json { render :show, status: :created, location: @occurrence }
      else
        format.html { render :new }
        format.json { render json: @occurrence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /occurrences/1
  # PATCH/PUT /occurrences/1.json
  def update
    respond_to do |format|
      if @occurrence.update(occurrence_params)
        format.html { redirect_to get_route(:index), notice: translate_message(:updated) }
        format.json { render :show, status: :ok, location: @occurrence }
      else
        format.html { render :edit }
        format.json { render json: @occurrence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /occurrences/1
  # DELETE /occurrences/1.json
  def destroy
    @occurrence.destroy
    respond_to do |format|
      format.html { redirect_to get_route(:index), notice: translate_message(:destroyed) }
      format.json { head :no_content }
    end
  end

  def get_available_intervals
    render json: {
      available_intervals: Occurrence.get_available_intervals(ServiceStation.find(params[:service_station_id]), params[:occurrence_nature_id])
    }, status: :ok
  end

  # GET /occurrences/:event_id/report
  def report
    @event = Event.find(params[:event_id])
    params[:intervals].delete("")
    @selected_intervals = params[:intervals]
    set_service_station unless params[:service_station_id].empty?
    
    @occurrence_nature_with_intervals = OccurrenceNature.get_all_by_type_and_interval(@selected_intervals)
    Occurrence.get_to_index_view(@occurrence_nature_with_intervals, @event, @service_station)

    respond_to do |format|
      format.html
      format.pdf do
        render(pdf:         "Relatorio_Ocorrencias_#{@event.description}",
               template:    'occurrences/report.pdf.erb',
               orientation: 'Landscape',
               page_size:   'A4')
      end
    end
  end

  # GET /occurrences/report_by_ome_and_date
  def report_by_ome_and_date
    @ome_list = Sgp::Ome.operational_managements.map{ |ome| {id: ome.id, acronym: ome.acronym, column_name: "ome_id_#{ome.id}"} }
    @occurrence_nature_with_omes = OccurrenceNature.get_all_by_ome( @ome_list.pluck(:column_name) )
    Occurrence.fill_report_table_by_omes_and_date(@occurrence_nature_with_omes, params[:report_interval], @ome_list.pluck(:id))
    
    respond_to do |format|
      format.html
      format.xlsx
      format.pdf do
        render(pdf:         "Relatorio_Ocorrencias",
               template:    'occurrences/report_by_ome_and_date.pdf.erb',
               orientation: 'Landscape',
               page_size:   'A4')
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_occurrence
      @occurrence = Occurrence.find(params[:id])
    end

    def set_occurrence_interval
      @occurrence_interval = @service_station.event.get_interval_list
    end

    def set_service_station
      @service_station = @occurrence.present? && @occurrence.service_station_id ? @occurrence.service_station : ServiceStation.find(params[:service_station_id])
    end

    def get_route(action = :index)
      @action_route = "/occurrences/#{@service_station.id}/#{action.to_s}/"
    end
    
    def set_occurrence_natures
      @occurrence_natures = OccurrenceNature.get_without_technical_services_type(OccurrenceType.get_technical_services_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def occurrence_params
      params.require(:occurrence).permit(:interval, :start_time, :final_time, :amount, :occurrence_nature_id, :service_station_id, :event_id)
    end
end