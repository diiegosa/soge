class ServiceStationWorkShift < ApplicationRecord
  belongs_to :service_station
  validates_numericality_of :militaries_quantity, greater_than_or_equal_to: 0

  def self.update_values_by_work_shift_amount_of_event(event, new_work_shift_amount)
    where(service_station_id: event.service_stations.pluck(:id) ).where("work_shift > ?", new_work_shift_amount).destroy_all
  end
end
