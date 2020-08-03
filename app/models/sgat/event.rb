class Sgat::Event < ApplicationRecord
	establish_connection(:portal_sistemas)
    self.table_name = 'ovrsgat.tb_projt'

    # periodo do evento
    def self.get_by_protocol(protocolo)
        query = <<-SQL
            SELECT prot.nr_protc, req.nr_cap_max_pess, req.dt_fim_valid, sit.id_sitc_req,
            CASE WHEN req.ic_pess = 'PJ' THEN req.nm_razao_socl ELSE req.nm_pess end as nm_pess,
            CASE WHEN sit.id_sitc_req = 9 THEN 'Regularizado' ELSE 'Em andamento' end as status,
            en.ds_endr, en.nr_endr, en.ds_compl, en.nr_cep, en.ds_bair, en.ds_cidd, en.sg_uf
            FROM ovrsgat.tb_req_visto AS req
            LEFT JOIN ovrsgat.tb_projt proj ON proj.id_projt = req.id_projet_fk
            LEFT JOIN ovrsac.tb_protc prot ON req.id_protc_fk = prot.id_protc
            LEFT JOIN ovrsgat.tb_sitc_req sit ON sit.id_sitc_req = req.id_sitc_req_fk
            LEFT JOIN ovrsgat.tb_endr en ON en.id_visto_fk = req.id_req_visto
            WHERE prot.nr_protc = '#{protocolo}'
        SQL
        find_by_sql(query).first
    end

    def address
        str = ""
        str << "#{self.ds_endr}, " if self.ds_endr.present?
        str << "#{self.nr_endr}, " if self.nr_endr.present?
        str << "#{self.ds_compl}, " if self.ds_compl.present?
        str << "CEP: #{self.nr_cep}, " if self.nr_cep.present?
        str << "#{self.ds_bair}, " if self.ds_bair.present?
        str << "#{self.ds_cidd} - " if self.ds_cidd.present?
        str << "#{self.sg_uf} " if self.sg_uf.present?
        str        
    end

    def is_regularized?
        self.id_sitc_req == 9
    end
end