json.extract! event, :id, :description, :start_time, :final_time, :occurrence_interval, :work_shift_amount, :created_at, :updated_at
json.url event_url(event, format: :json)
