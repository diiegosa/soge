class Event < ApplicationRecord
    has_and_belongs_to_many :command_posts
    has_many :service_stations
    has_one :management, primary_key: "sgp_ome_id", foreign_key: "id_ome", class_name: "Sgp::Ome"
    has_one :city, primary_key: "sac_city_id", foreign_key: "id_cidd_x_ome", class_name: "Sac::City"
    has_many :occurrences
    validates :sac_city_id, :sgp_ome_id, :description, presence: true
    validates :occurrence_interval, :work_shift_amount, presence: true
    validates_numericality_of :occurrence_interval, greater_than_or_equal_to: 1
    validates_numericality_of :work_shift_amount, greater_than_or_equal_to: 1
    validate :description_registered_validate
    default_scope { order(:sac_city_id) }
    scope :not_include_me, -> (id) { where.not(id: id.nil? ? 0 : id)}
    attribute :duration_time
    attribute :command_posts
    attribute :start_time_to_index

    private def initialize(params = {})
        prepare_params(params) if all_params_present?(params)
        super(params)
    end

    def description_registered_validate
        events = Event.where(description: self[:description]).where("DATE(start_time) = ?", start_time.strftime("%Y/%m/%d")).where(sac_city_id: sac_city_id).not_include_me(id)
        self.errors[:base] << "Já existe um evento com o nome: #{description}, na cidade: #{city.name}, na data: #{start_time.strftime("%d/%m/%Y")}" if events.any?
    end

    def description=(description)
        self[:description] = description.upcase.strip
    end
    
    def description
        self[:description].titleize rescue ""
    end

    def start_time_to_index
        self[:start_time].strftime("%d/%m/%Y %H:%M")
    end

    def self.search(cities_id_by_name, params)
        where("description ILIKE ?", "%#{params}%").or(where(sac_city_id: cities_id_by_name))
    end

    def all_params_present?(params)
        params[:sac_city_id].present? &&
        params[:sgp_ome_id].present? && 
        params[:description].present? && 
        params[:duration_time].present? && 
        params[:occurrence_interval].present? && 
        params[:work_shift_amount].present?
    end

    def prepare_params(params)
        duration_time = params[:duration_time].split(' - ')
        params[:start_time] = duration_time[0] 
        params[:final_time] = duration_time[1]
        params[:command_post_ids] = CommandPost.get_ids_in_order(params[:command_post_ids])
        params
    end

    def update(params)
        ServiceStationWorkShift.update_values_by_work_shift_amount_of_event(self, params[:work_shift_amount]) if params[:work_shift_amount].to_i < work_shift_amount
        super(prepare_params(params))
    end

    def get_interval_list
        datetime = start_time
        interval_list = {}
    
        while datetime <= final_time 
          interval_list["#{datetime} - #{datetime + occurrence_interval.hours - 1.minute}"] = 
            "#{format_date_to_show(datetime)} - #{format_date_to_show(datetime + occurrence_interval.hours - 1.minute)}"
    
          datetime += occurrence_interval.hours
        end
    
        interval_list
    end

    def duration_time
        if start_time.present? && final_time.present?  
            "#{start_time.strftime("%d/%m/%Y %H:%M")} - #{final_time.strftime("%d/%m/%Y %H:%M")}"
        end
    end

    def self.all_city_ids_that_have_event
        select(:sac_city_id).distinct.map{ |event| event.sac_city_id }
    end

    def self.by_city_id(city_id)
        where(sac_city_id: city_id)
    end

    def get_militaries_quantity_by_work_shift
        service_stations_ids = service_stations.pluck(:id)
        militaries_quantity = ServiceStationWorkShift.where(service_station_id: service_stations_ids).group(:work_shift).order(work_shift: :asc).limit(work_shift_amount).sum(:militaries_quantity)
        
        #Verifica se a quantidade de militares retornada no BD está conforme a quantidade de turno do evento e, se for o caso, adiciona os turnos faltantes
        if militaries_quantity.count < work_shift_amount
            ((militaries_quantity.count+1)..work_shift_amount).each do |new_work_shift|
                militaries_quantity = militaries_quantity.merge(new_work_shift => 0)
            end
        end
        militaries_quantity
    end

    def get_vehicles_quantity_by_work_shift
        service_stations_ids = service_stations.where(service_station_type_id: ServiceStationType.get_vehicle_id).pluck(:id)
        
        query = <<-SQL
            select ws.work_shift,
            SUM((
                select count(ss.id) from service_stations ss
                where ss.id	= ws.service_station_id and ws.militaries_quantity > 0 and
                ss.id IN (#{ service_stations_ids.present? ? service_stations_ids.join(',') : 0})
            )) as vehicle_quantity
            from service_station_work_shifts ws
            group by ws.work_shift
            order by ws.work_shift asc
            limit #{work_shift_amount}
        SQL

        vehicles_quantity = ServiceStationWorkShift.find_by_sql(query)
        
        #Verifica se a quantidade de viaturas retornada no BD está conforme a quantidade de turno do evento e, se for o caso, adiciona os turnos faltantes
        if vehicles_quantity.count < work_shift_amount
            ((vehicles_quantity.count+1)..work_shift_amount).each do |new_work_shift|
                vehicles_quantity = vehicles_quantity.concat([{work_shift: new_work_shift, vehicle_quantity: 0}])
            end
        end
        vehicles_quantity
    end

    def self.get_time_in_interval_to_show(interval)
        "#{interval.split(' - ')[0].to_datetime.strftime("%H:%M")}-#{interval.split(' - ')[1].to_datetime.strftime("%H:%M")}"
    end

    private
        def format_date_to_show(datetime)
            datetime.strftime("%H:%M (%d/%m/%Y)")
        end
end