puts "Cadastrando Tipos De Ocorrências..."
occurrence_types =  
  [
    {
      description: OccurrenceType::NAMES[:TECHNICAL_SERVICES]
    },
    {
      description: OccurrenceType::NAMES[:OPERATIONAL_TECHNICAL_SERVICES]
    },
    {
      description: OccurrenceType::NAMES[:FIRE_SERVICES]
    },
    {
      description: OccurrenceType::NAMES[:RESCUE_SERVICES]
    },
    {
      description: OccurrenceType::NAMES[:PRE_HOSPITAL_SERVICES]
    },
    {
      description: OccurrenceType::NAMES[:PREVENTION]
    }
  ]
occurrence_types.each do |occurrence_type|
  OccurrenceType.find_or_create_by!(occurrence_type)
end