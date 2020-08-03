class CreateTechnicalServices < ActiveRecord::Migration[5.1]
  def change
    create_table :technical_services do |t|
      t.datetime :start_time
      t.datetime :final_time
      t.references :sgp_military, index: true, null: false
      t.references :technical_service_interval, foreign_key: true

      t.timestamps
    end
  end
end
