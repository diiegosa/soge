class ServiceStationType < ApplicationRecord
    NAMES = {
        APH: 'GRUPO DE INTERVENÇÃO DE ATENDIMENTO PRÉ-HOSPITALAR',
        SEARCH_AND_RESCUE: 'GRUPO DE INTERVENÇÃO DE BUSCA E SALVAMENTO',
        FIRE: 'GRUPO DE INTERVENÇÃO DE INCÊNDIO',
        DIVING: 'GRUPO DE INTERVENÇÃO DE MERGULHO',
        AQUATIC_RESCUE: 'GRUPO DE INTERVENÇÃO DE SALVAMENTO AQUÁTICO (GUARDA-VIDAS)',
        VEHICLE: 'GRUPO EM VIATURA',
        OBSERVATION_PLATFORM: 'GRUPO EM PLATAFORMA DE OBSERVAÇÃO',
    }

    def self.get_vehicle_id 
        find_by(description: NAMES[:VEHICLE]).id
    end

    def is_vehicle?
        id == ServiceStationType::get_vehicle_id
    end
    
    def self.is_vehicle?(id)
        id == ServiceStationType::get_vehicle_id
    end
end