class CreateTechnicalServiceIntervals < ActiveRecord::Migration[5.1]
  def change
    create_table :technical_service_intervals do |t|
      t.string :description
      t.integer :year

      t.timestamps
    end
  end
end
