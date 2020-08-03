class OccurrenceType < ApplicationRecord
    has_many :occurrence_natures
    default_scope { order(:description) }

    NAMES = {
        TECHNICAL_SERVICES: 'SERVIÇOS TÉCNICOS',
        OPERATIONAL_TECHNICAL_SERVICES: 'SERVIÇOS TÉCNICOS (OPERACIONAL)',
        FIRE_SERVICES: 'INCÊNDIO',
        RESCUE_SERVICES: 'SALVAMENTO',
        PRE_HOSPITAL_SERVICES: 'ATENDIMENTO PRÉ-HOSPITALAR',
        PREVENTION: 'PREVENÇÃO'
    }

    def self.get_without_technical_services
        where.not(id: self.get_technical_services_id)
    end

    def self.get_technical_services_id 
        find_by(description: NAMES[:TECHNICAL_SERVICES]).id
    end

    def self.get_operational_technical_services_id 
        find_by(description: NAMES[:OPERATIONAL_TECHNICAL_SERVICES]).id
    end

    def self.get_fire_services_id 
        find_by(description: NAMES[:FIRE_SERVICES]).id
    end

    def self.get_rescue_services_id 
        find_by(description: NAMES[:RESCUE_SERVICES]).id
    end

    def self.get_pre_hospital_services_id 
        find_by(description: NAMES[:PRE_HOSPITAL_SERVICES]).id
    end
    
    def self.get_prevention_id 
        find_by(description: NAMES[:PREVENTION]).id
    end
end