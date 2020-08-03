class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :occurrence_amount_by_service_station, :occurrence_amount_by_nature, :occurrence_amount_by_type]
  before_action :set_dependences, only: [:new, :home_new, :create, :edit, :update]

  def index
    @q = Event.ransack(params[:q])
    if(params.include?("city_selected"))
      @events = Event.by_city_id(params[("city_selected")])
    else
      search = params.include?(:q) && params[:q].include?(:description_or_city_name_cont) ? params[:q][:description_or_city_name_cont] : ""
      cities_id_by_name = Sac::City.search_ids_by_name(Event.all_city_ids_that_have_event, search)
      @events = Event.search(cities_id_by_name, search)
    end
  end

  def occurrence_amount_by_service_station
    render json: {
      result: @event.service_stations.map { |e| {name: e.acronym, quantity: e.occurrences.sum(:amount)} }
    }, status: :ok
  end

  def occurrence_amount_by_interval    
    render json: {
      result: @event.get_interval_list.map { |interval| {
          name: Event.get_time_in_interval_to_show(interval[1]),
          amount: @event.occurrences.where(start_time: interval[0].split(' - ')[0], final_time: interval[0].split(' - ')[1]).sum(:amount)
        }
      }
    }, status: :ok
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  def home_new
    @event = Event.new
    render :home_new
  end
  

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to edit_event_path(@event.id), notice: translate_message(:created) }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to edit_event_path(@event.id), notice: translate_message(:updated) }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: translate_message(:destroyed) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end
    
    def set_dependences
      @cities = Sac::City.all
      @managements = Sgp::Ome.operational_managements
      @command_posts = CommandPost.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:sac_city_id, :sgp_ome_id, :description, :start_time, :final_time, :duration_time, :occurrence_interval, :work_shift_amount, command_post_ids: [] )
    end
end