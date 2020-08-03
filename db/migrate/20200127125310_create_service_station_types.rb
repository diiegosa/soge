class CreateServiceStationTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :service_station_types do |t|
      t.string :description

      t.timestamps
    end
  end
end
