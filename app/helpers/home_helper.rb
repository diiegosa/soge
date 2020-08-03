module HomeHelper

    def get_default_interval()
        "#{Date.today.strftime('01/01/%Y')} - #{Date.today.strftime('%d/%m/%Y')}"
    end

end
