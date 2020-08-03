class ServiceStation < ApplicationRecord
  belongs_to :event
  belongs_to :command_post
  belongs_to :service_station_type
  has_many :occurrences
  has_many :service_station_work_shifts, dependent: :destroy
  has_one :service_station_vehicle_type, dependent: :destroy
  validates :description, :acronym, presence: true
  
  scope :by_event, -> (event_id) { where(event_id: event_id) }
  scope :not_include_me, -> (id) { where.not(id: id.nil? ? 0 : id)}
  accepts_nested_attributes_for :service_station_work_shifts, :service_station_vehicle_type

  def description=(description)
    self[:description] = description.upcase.strip
  end

  def description
      self[:description].upcase
  end

  def acronym=(acronym)
    self[:acronym] = acronym.upcase.strip
  end

  def acronym
      self[:acronym].upcase
  end

  def presence_vehicle_validate(params)
    ServiceStationType.is_vehicle?(params[:service_station_type_id].to_i) && 
      (!params.include?(:service_station_vehicle_type_attributes) || params[:service_station_vehicle_type_attributes][:vehicle_type_id].empty?)
  end

  def check_if_not_vehicle(params)
    params.delete(:service_station_vehicle_type_attributes) if !ServiceStationType.is_vehicle?(params[:service_station_type_id].to_i) && params.include?(:service_station_vehicle_type_attributes)
  end
  

  def check_presence_vehicle_validate(params)
    errors.add(:base, "Selecione um Tipo de Posto de Atendimento") and return if params[:service_station_type_id].empty?
    errors.add(:base, "Selecione uma Viatura") if presence_vehicle_validate(params)
  end

  def check_unique_description_and_acronym_by_event(params)
    service_stations = ServiceStation.where("upper(description) = ?", params[:description].upcase.strip).where(event_id: event_id).not_include_me(id)
    errors.add(:base, "Já existe um Posto de Atendimento com o nome: #{params[:description]}, neste evento") if service_stations.any?
    service_stations = ServiceStation.where("upper(acronym) = ?", params[:acronym].upcase.strip).where(event_id: event_id).not_include_me(id).not_include_me(id)
    errors.add(:base, "Já existe um Posto de Atendimento com a sigla: #{params[:acronym]}, neste evento") if service_stations.any?
  end

  private def validate(params)
    check_presence_vehicle_validate(params)
    check_unique_description_and_acronym_by_event(params)
    check_if_not_vehicle(params)
  end

  def create(params)
    validate(params)
    !errors.any? && save
  end

  def update(params)
    validate(params)
    !errors.any? && super(params)
  end

end