json.extract! service_station, :id, :description, :acronym, :event_id, :command_post_id, :service_station_type_id, :created_at, :updated_at
json.service_station_work_shifts service_station.service_station_work_shifts

json.service_station_vehicle_type do
    json.id service_station.service_station_vehicle_type.id
    json.service_station_id service_station.service_station_vehicle_type.service_station_id
    json.vehicle_type_id service_station.service_station_vehicle_type.vehicle_type_id

    json.vehicle_type do
        json.id service_station.service_station_vehicle_type.vehicle_type.id
        json.description service_station.service_station_vehicle_type.vehicle_type.description
    end

end unless service_station.service_station_vehicle_type.nil?

json.service_station_type service_station.service_station_type
json.url service_station_url(service_station, format: :json)
