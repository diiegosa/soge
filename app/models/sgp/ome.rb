class Sgp::Ome < ApplicationRecord
	establish_connection(:portal_sistemas)
    self.table_name = 'ovrsgp.tb_ome'
    
    # Diretorias
    scope :operational_managements, -> { where(nr_nivel_ome: 2, ic_tipo: 'OP').where.not(id_ome: 42).order(nm_ome: :asc) }

    alias_attribute :id, :id_ome
    alias_attribute :name, :nm_ome
    alias_attribute :acronym, :sg_ome

    def id
        super.to_i
    end

    def self.get_diesp_id
        find_by(sg_ome: "DIESP").id
    end

end