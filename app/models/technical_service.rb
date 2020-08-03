class TechnicalService < ApplicationRecord
  belongs_to :technical_service_interval
  has_many :technical_service_occurrences, dependent: :destroy
  belongs_to :military, foreign_key: "sgp_military_id", class_name: "Sgp::Military"

  validates :sgp_military_id, presence: true

  accepts_nested_attributes_for :technical_service_occurrences

  attribute :duration_time

  def initialize(params = {})
    prepare_params(params) if params[:duration_time].present?
    super(params)
  end

  def start_time
    super.strftime("%d/%m/%Y - %Hh%Mmin")
  end

  def final_time
    super.strftime("%d/%m/%Y - %Hh%Mmin")
  end

  def get_date(datetime)
    date_and_time = datetime.split(' - ')
    date = date_and_time[0]
    date
  end
  
  def get_time(datetime)
    date_and_time = datetime.split(' - ')
    time = date_and_time[1]
    time
  end

  def prepare_params(params)
    duration_time = params[:duration_time].split(' - ')

    params[:start_time] = duration_time[0] 
    params[:final_time] = duration_time[1]
    params
  end

  def update(params)
      super(prepare_params(params))
  end

  def duration_time
    if start_time.present? && final_time.present?  
        "#{self[:start_time].strftime("%d/%m/%Y %H:%M")} - #{self[:final_time].strftime("%d/%m/%Y %H:%M")}"
    end
  end

end
