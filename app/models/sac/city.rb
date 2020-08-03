class Sac::City < ApplicationRecord
	establish_connection(:portal_sistemas)
    self.table_name = 'ovrsac.tb_cidd_x_ome'
    has_many :events
    default_scope { order(ds_cidd: :asc) }
    scope :has_event, ->(ids) {where(id:ids)}
    alias_attribute :id, :id_cidd_x_ome
    alias_attribute :name, :ds_cidd

    def id
        super.to_i
    end

    def self.search_ids_by_name(city_ids, params)
        select(:id).has_event(city_ids).where("ds_cidd ILIKE ?", "%#{params}%").map{ |city| city.id }
    end
    
end