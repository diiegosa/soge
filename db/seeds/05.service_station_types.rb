puts "Cadastrando Tipos De Postos De Atendimento..."
service_station_types = [
                    {
                        description: ServiceStationType::NAMES[:APH]
                    },
                    {
                        description: ServiceStationType::NAMES[:SEARCH_AND_RESCUE]
                    },
                    {
                        description: ServiceStationType::NAMES[:FIRE]
                    },
                    {
                        description: ServiceStationType::NAMES[:DIVING]
                    },
                    {
                        description: ServiceStationType::NAMES[:AQUATIC_RESCUE]
                    },
                    {
                        description: ServiceStationType::NAMES[:VEHICLE]
                    },
                    {
                        description: ServiceStationType::NAMES[:OBSERVATION_PLATFORM]
                    }
                ]
service_station_types.each do |service_station_type|
  ServiceStationType.find_or_create_by!(service_station_type)
end