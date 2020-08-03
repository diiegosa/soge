class Sgp::Military < ApplicationRecord
	establish_connection(:portal_sistemas)
    self.table_name = 'ovrsgp.tb_pess'

    default_scope { order(nm_pess: :asc) }

    alias_attribute :id, :id_pess
    alias_attribute :name, :nm_pess
    alias_attribute :war_name, :nm_guerr
    alias_attribute :registration, :nr_matr_pess

    def id
        super.to_i
	end
	
    has_many :promotions, class_name: 'Sgp::Promotion', 
		primary_key: 'id_pess', foreign_key: 'id_pess_fk'

	# Cached function
	def self.fetch_all
		Rails.cache.fetch(["militaries", __method__], expires_in: 2.hours) do
			connection.select_all <<-SQL
				SELECT pess.id_pess AS id, pess.nm_pess, pess.nm_guerr, pess.nr_matr_pess AS registration, cargo.sg_cargo,
				CONCAT(cargo.sg_cargo, ' - ',pess.nm_pess, ' - ', pess.nr_matr_pess) as custom_name
				FROM ovrsgp.tb_pess AS pess
				JOIN ovrsgp.tb_prom AS prom ON prom.id_pess_fk = pess.id_pess
				JOIN (
					SELECT id_pess_fk, MAX(dt_prom) AS dt_prom 
					FROM ovrsgp.tb_prom 
					GROUP BY id_pess_fk
				) AS aux_prom ON aux_prom.id_pess_fk = prom.id_pess_fk AND aux_prom.dt_prom = prom.dt_prom
				JOIN ovrsgp.tb_cargo AS cargo ON cargo.id_cargo = prom.id_cargo_fk
				ORDER BY cargo.ds_hiera_cargo  
			SQL
		end
	end

	def patent
        promotion = promotions.order('dt_promv DESC').first
        promotion.patent
	end

end