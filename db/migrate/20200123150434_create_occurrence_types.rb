class CreateOccurrenceTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :occurrence_types do |t|
      t.string :description

      t.timestamps
    end
  end
end
