class ServiceStationVehicleType < ApplicationRecord
  belongs_to :service_station
  belongs_to :vehicle_type

end