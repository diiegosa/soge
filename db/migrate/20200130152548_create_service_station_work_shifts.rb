class CreateServiceStationWorkShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :service_station_work_shifts do |t|
      t.references :service_station, foreign_key: true
      t.integer :work_shift
      t.integer :militaries_quantity

      t.timestamps
    end
  end
end
