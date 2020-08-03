class AddAboutToVehicleTypes < ActiveRecord::Migration[5.1]
  def up
    add_column :vehicle_types, :about, :string
  end

  def down
    remove_column :vehicle_types, :about
  end
end
