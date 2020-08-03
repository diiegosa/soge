class CreateOccurrenceNatures < ActiveRecord::Migration[5.1]
  def change
    create_table :occurrence_natures do |t|
      t.string :description
      t.references :occurrence_type, foreign_key: true

      t.timestamps
    end
  end
end
