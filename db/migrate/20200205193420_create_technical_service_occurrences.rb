class CreateTechnicalServiceOccurrences < ActiveRecord::Migration[5.1]
  def change
    create_table :technical_service_occurrences do |t|
      t.references :technical_service, foreign_key: true
      t.references :occurrence_nature, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
