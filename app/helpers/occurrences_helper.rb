module OccurrencesHelper
    def get_title(service_station)
        "#{service_station.event.description} - #{service_station.acronym}"
    end
    
    def generate_columns_of_occurrence_nature_amount_by_interval(occurrence_nature, column_names)
        total = 0
        html_columns = ""
        
        column_names.each do |column_name|
            html_columns << "<td class=\"text-center\">#{occurrence_nature[column_name] || '0'}</td>"
            total = total+(occurrence_nature[column_name].nil? ? 0 : occurrence_nature[column_name])
        end
        
        html_columns << "<td class=\"text-center\">#{total}</td>"

        html_columns.html_safe
    end

    def get_hour_of_interval(interval)
        date_and_time = interval.split(' - ')
        time_start = date_and_time[0].split('(').first
        time_end = date_and_time[1].split('(').first
        "#{time_start} - #{time_end}"
    end
end
