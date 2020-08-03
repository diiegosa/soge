module EventsHelper
    def check_box_input(command_post, registered_command_posts)
        checked = '' 

        registered_command_posts.each do |registered_command_post| 
            checked = "checked = ''" if command_post.acronym == registered_command_post.acronym 
        end

        CommandPost.is_pcg?(command_post) ? 
            ("<input name='event[command_post_ids][]' class='custom-control-input' id='checkBox"+command_post.id.to_s+"' type='checkbox' checked='' value='"+command_post.id.to_s+"' disabled=''>").html_safe
                :
                    ("<input name='event[command_post_ids][]' class='custom-control-input' id='checkBox"+command_post.id.to_s+"' #{checked} type='checkbox' value='"+command_post.id.to_s+"'>").html_safe
    end

    def get_percentual_of_occurrence_nature(occurrence_nature_amount)
        "#{(100 * occurrence_nature_amount)/@event.occurrences.sum(:amount)}%"
    end

    def get_color_and_icon(description)
        case description
        when OccurrenceType::NAMES[:OPERATIONAL_TECHNICAL_SERVICES]
            { color: 'bg-secondary', icon: 'fa fa-exclamation-triangle' }
        when OccurrenceType::NAMES[:FIRE_SERVICES]
            { color: 'bg-danger', icon: 'fa fa-fire-extinguisher' }
        when OccurrenceType::NAMES[:RESCUE_SERVICES]
            { color: 'bg-orange', icon: 'fa fa-truck' }
        when OccurrenceType::NAMES[:PRE_HOSPITAL_SERVICES]
            { color: 'bg-warning', icon: 'fa fa-ambulance' }
        when OccurrenceType::NAMES[:PREVENTION]
            { color: 'bg-success', icon: 'fa fa-bullhorn' }
        else
            { color: 'bg-info', icon: 'fa fa-exclamation-triangle' }
        end
    end

end