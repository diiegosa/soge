class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :description
      t.datetime :start_time
      t.datetime :final_time
      t.integer :occurrence_interval
      t.integer :work_shift_amount
      t.references :sac_city, index: true, null: false
      t.references :sgp_ome, index: true, null: false
      
      t.timestamps
    end
  end
end
