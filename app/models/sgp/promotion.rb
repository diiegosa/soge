class Sgp::Promotion < ApplicationRecord
	establish_connection(:portal_sistemas)
    self.table_name = 'ovrsgp.tb_prom'
    
    belongs_to :patent, class_name: 'Sgp::Patent', foreign_key: 'id_cargo_fk'
end