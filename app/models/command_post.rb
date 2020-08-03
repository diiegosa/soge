class CommandPost < ApplicationRecord
    has_and_belongs_to_many :events
    has_many :service_stations

    
    GET = {
        PCG: { DESCRIPTION: "Posto De Comando Geral", ACRONYM: "PCG" },
        PCAA: { DESCRIPTION: "Posto De Comando De Área A", ACRONYM: "PCA-A" },
        PCAB: { DESCRIPTION: "Posto De Comando De Área B", ACRONYM: "PCA-B" },
        PCAC: { DESCRIPTION: "Posto De Comando De Área C", ACRONYM: "PCA-C" },
    }

    def get_service_stations_by_event(event_id)
        service_stations.where(event_id: event_id)
    end

    def self.is_pcg?(command_post)
        GET[:PCG][:ACRONYM] == command_post.acronym 
    end

    def self.get_without_pcg
        where.not(acronym: GET[:PCG][:ACRONYM])
    end

    def self.get_ids_in_order(command_post_ids)
        command_post_ids_in_order = [find_by(acronym: GET[:PCG][:ACRONYM]).id]
        if(command_post_ids.present?)
            get_without_pcg.each_with_index do |command_post, index|
                command_post_ids_in_order.push(command_post.id) if index < command_post_ids.length
            end
        end
        command_post_ids_in_order
    end
    
    

end