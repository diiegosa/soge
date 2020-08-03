class TechnicalServiceOccurrence < ApplicationRecord
  belongs_to :technical_service
  belongs_to :occurrence_nature
end