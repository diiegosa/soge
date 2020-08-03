class CreateServiceStations < ActiveRecord::Migration[5.1]
  def change
    create_table :service_stations do |t|
      t.string :description
      t.string :acronym
      t.integer :militaries_quantity
      t.integer :work_shift
      t.references :event, foreign_key: true
      t.references :command_post, foreign_key: true
      t.references :service_station_type, foreign_key: true

      t.timestamps
    end
  end
end
