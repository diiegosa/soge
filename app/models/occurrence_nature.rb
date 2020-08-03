class OccurrenceNature < ApplicationRecord
  belongs_to :occurrence_type
  default_scope { order(:description) }

  def self.get_all_by_type_and_interval(interval_list)
    self.find_by_sql <<-SQL
      SELECT 
        nat.id AS id,
        oc_type.description AS occurrence_type_name,
        nat.description AS occurrence_nature,
        #{generate_custom_columns(interval_list)}
      FROM occurrence_natures AS nat
      JOIN occurrence_types AS oc_type ON nat.occurrence_type_id = oc_type.id
      WHERE oc_type.id <> #{OccurrenceType.get_technical_services_id}
      ORDER BY occurrence_type_name, occurrence_nature
    SQL
  end

  def self.generate_custom_columns(column_list)
    column_list.delete("")
    column_list.map{ |v| %(0 AS "#{v}")}.join(", ")
  end

  def self.get_all_by_ome(ome_list)
    self.find_by_sql <<-SQL
      SELECT 
        nat.id AS id,
        oc_type.id AS occurrence_type_id,
        oc_type.description AS occurrence_type_name,
        nat.description AS occurrence_nature,
        #{generate_custom_columns(ome_list)}
      FROM occurrence_natures AS nat
      JOIN occurrence_types AS oc_type ON nat.occurrence_type_id = oc_type.id
      ORDER BY occurrence_type_name, occurrence_nature
    SQL
  end

  def self.generate_ome_columns(ome_list)
    ome_list.delete("")
    ome_list.map{ |v| %(0 AS "#{v}")}.join(", ")
  end

  def self.get_by_technical_services_type
    where(occurrence_type_id: OccurrenceType.get_technical_services_id)
  end

  def self.get_without_technical_services_type(occurrence_type_id)
    where.not(occurrence_type_id: occurrence_type_id)
  end
  
end
