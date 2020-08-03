class RemoveWorkShiftAndMilitariesQuantityFromServiceStations < ActiveRecord::Migration[5.1]
  def up
    remove_column :service_stations, :work_shift
    remove_column :service_stations, :militaries_quantity
  end

  def down
    add_column :service_stations, :work_shift, :integer
    add_column :service_stations, :militaries_quantity, :integer
  end
end
