class CreateServiceStationVehicleTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :service_station_vehicle_types do |t|
      t.references :service_station, foreign_key: true
      t.references :vehicle_type, foreign_key: true

      t.timestamps
    end
  end
end
