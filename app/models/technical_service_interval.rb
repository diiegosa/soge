class TechnicalServiceInterval < ApplicationRecord

    def description
        "#{super}/#{self.year}"
    end
end
