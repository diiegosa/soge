class CreateOccurrences < ActiveRecord::Migration[5.1]
  def change
    create_table :occurrences do |t|
      t.datetime :start_time
      t.datetime :final_time
      t.integer :amount
      t.references :occurrence_nature, foreign_key: true
      t.references :service_station, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
