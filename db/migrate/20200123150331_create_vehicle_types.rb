class CreateVehicleTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicle_types do |t|
      t.string :description
      t.string :acronym

      t.timestamps
    end
  end
end
