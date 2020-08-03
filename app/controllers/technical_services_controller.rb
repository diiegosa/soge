class TechnicalServicesController < ApplicationController
  layout "home", only: [:qrcode_verify]
  before_action :set_technical_service, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:qrcode_verify]
  skip_load_and_authorize_resource

  # GET /technical_services
  # GET /technical_services.json
  def index
    @q = TechnicalService.order('created_at desc').ransack(params[:q])
    @technical_services = @q.result(distinct: true)
  end

  # GET /technical_services/1
  # GET /technical_services/1.json
  def show
  end

  # GET /technical_services/new
  def new
    @technical_service = TechnicalService.new

    OccurrenceNature.get_by_technical_services_type.each do |occurrence_nature|
      @technical_service.technical_service_occurrences.build.occurrence_nature_id = occurrence_nature.id
    end if @technical_service.technical_service_occurrences.empty?
  end

  # GET /technical_services/1/edit
  def edit
  end

  # POST /technical_services
  # POST /technical_services.json
  def create
    @technical_service = TechnicalService.new(technical_service_params)
    respond_to do |format|
      if @technical_service.save
        format.html { redirect_to technical_services_path, notice: translate_message(:created) }
        format.json { render :show, status: :created, location: @technical_service }
      else
        format.html { render :new }
        format.json { render json: @technical_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /technical_services/1
  # PATCH/PUT /technical_services/1.json
  def update
    respond_to do |format|
      if @technical_service.update(technical_service_params)
        format.html { redirect_to technical_services_path, notice: translate_message(:updated) }
        format.json { render :show, status: :ok, location: @technical_service }
      else
        format.html { render :edit }
        format.json { render json: @technical_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /technical_services/1
  # DELETE /technical_services/1.json
  def destroy
    @technical_service.destroy
    respond_to do |format|
      format.html { redirect_to technical_services_url, notice: translate_message(:destroyed) }
      format.json { head :no_content }
    end
  end

  def qrcode_generate
    protocol = params[:protocol]
    respond_to do |format|
      if protocol && @event = Sgat::Event.get_by_protocol(protocol)
        url = "#{request.base_url}/qrcode_verify/#{protocol}"
        qrcode = RQRCode::QRCode.new(url)
        @base64_output = Base64.encode64(qrcode.as_png(size: 420).to_s)
      end
      format.html
      format.pdf do
        render(pdf:         protocol.to_s,
               template:    'technical_services/qrcode_generate.pdf.erb',
               orientation: 'Landscape',
               page_size:   'A3')
      end
    end
  end

  def qrcode_verify
    @event = Sgat::Event.get_by_protocol(params[:protocol])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_technical_service
      @technical_service = TechnicalService.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def technical_service_params
      params.require(:technical_service).permit(:start_time, :final_time, :duration_time, :sgp_military_id, :technical_service_interval_id,
        technical_service_occurrences_attributes:[
          :id, :occurrence_nature_id, :amount
        ]
      )
    end
end
