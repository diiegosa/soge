class Occurrence < ApplicationRecord
  belongs_to :occurrence_nature
  belongs_to :service_station
  belongs_to :event
  validates :interval, :occurrence_nature_id, presence: true
  validates :service_station_id, :amount, presence: true
  validates :start_time, uniqueness: { scope: [:occurrence_nature_id, :service_station_id], message: 'selecionado já possui um registro de ocorrência cadastrado dessa mesma natureza. Você pode clicar em "Voltar" e editar esse registro.' }
  validates_numericality_of :amount, greater_than_or_equal_to: 1
  scope :by_service_station, -> (service_station) { where(event_id: service_station.event_id).where(service_station_id: service_station.id) }
  attribute :interval

  def initialize(params = {})
    prepare_params(params) if all_params_present?(params)
    super(params)
  end

  def all_params_present?(params)
    params[:interval].present? &&
    params[:amount].present? && 
    params[:occurrence_nature_id].present? && 
    params[:service_station_id].present? && 
    params[:event_id].present?
  end

  def prepare_params(params)
    duration_time = params[:interval].split(' - ')
    params[:start_time] = duration_time[0] 
    params[:final_time] = duration_time[1]
    params
  end

  def interval
    if start_time.present? && final_time.present?  
      "#{start_time} - #{final_time}"
    end
  end

  def interval_to_show
    Occurrence.format_interval_to_show(start_time, final_time)
  end

  def nature_id
    occurrence_nature_id
  end

  def nature
    occurrence_nature
  end
  
  def nature_description
    nature.occurrence_type.description
  end

  def update(params)
    super(prepare_params(params))
  end

  def self.get_available_intervals(service_station, occurrence_nature_id)
    event = service_station.event
    datetime = event.start_time
    interval_list = []

    registered_occurrence_intervals = 
      select(:start_time).where(service_station_id: service_station.id).where(occurrence_nature_id: occurrence_nature_id)

    while datetime <= event.final_time 
      disabled = registered_occurrence_intervals.map{|v| v.start_time == datetime}
      final_time = datetime + (event.occurrence_interval.hours - 1.minute)
      
      interval_list.push({
        value: "#{datetime} - #{final_time}",
        description: "#{format_interval_to_show(datetime, final_time)}",
        disabled: disabled.include?(true),
      })
      datetime += event.occurrence_interval.hours
    end

    interval_list
  end

  def self.get_to_index_view(occurrence_nature_with_intervals, event, service_station = nil)
    occurrences = event.occurrences
    occurrences = occurrences.where(service_station_id: service_station.id) unless service_station.nil? #filtro por posto de atendimento
    occurrences.each do |occurrence|
      occurrence_nature_with_intervals.each do |occurrence_nature|
        occurrence_nature[occurrence.interval_to_show] += occurrence.amount if(occurrence.nature_id == occurrence_nature.id) && occurrence_nature[occurrence.interval_to_show].present?
      end
    end
  end

  def self.fill_report_table_by_omes_and_date(occurrence_nature_with_omes, date_interval, ome_ids)    
    date_start = date_interval.split(' - ')[0]
    date_end = date_interval.split(' - ')[1]

    occurrences = Occurrence.joins(:event).where(events: {sgp_ome_id: ome_ids}).where(start_time: date_start.to_date.strftime("%Y/%m/%d")..date_end.to_date.strftime("%Y/%m/%d"))
    technical_services = TechnicalServiceOccurrence.select(:occurrence_nature_id, "SUM(amount) as total").joins(:technical_service).where(technical_services: {start_time: date_start.to_date.strftime("%Y/%m/%d")..date_end.to_date.strftime("%Y/%m/%d")}).group(:occurrence_nature_id).map{ |occurrence_technical_service| [occurrence_technical_service.occurrence_nature_id, occurrence_technical_service.total] }.to_h

    occurrences.each do |occurrence|
      occurrence_nature_with_omes.each do |occurrence_nature|
        occurrence_nature["ome_id_#{occurrence.event.sgp_ome_id}"] += occurrence.amount if(occurrence.nature_id == occurrence_nature.id) && occurrence_nature["ome_id_#{occurrence.event.sgp_ome_id}"].present?

        if occurrence_nature.occurrence_type_id == OccurrenceType.get_technical_services_id
          occurrence_nature["ome_id_#{Sgp::Ome.get_diesp_id}"] = technical_services[occurrence_nature.id]
        end
      end
    end
  end

  def get_date(datetime)
    datetime.strftime("%d/%m/%Y")
  end
  
  def get_time(datetime)
    datetime.strftime("%H:%M")
  end

  private
  def self.format_interval_to_show(start_interval, final_interval)
    "#{format_date_to_show(start_interval)} - #{format_date_to_show(final_interval)}"
  end

  def self.format_date_to_show(datetime)
    datetime.strftime("%H:%M (%d/%m/%Y)")
  end
end