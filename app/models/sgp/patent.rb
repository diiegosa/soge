class Sgp::Patent < ApplicationRecord
	establish_connection(:portal_sistemas)
    self.table_name = 'ovrsgp.tb_cargo'

    alias_attribute :id, :id_cargo
    alias_attribute :name, :ds_cargo
    alias_attribute :acronym, :sg_cargo
    alias_attribute :hierarchy, :ds_hiera_cargo
end