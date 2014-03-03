json.array!(@events) do |event|
  json.extract! event, :id, :title, :description, :location, :start_time, :end_time, :all_day
  json.url event_url(event, format: :json)
end
