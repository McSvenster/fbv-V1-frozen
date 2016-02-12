json.array!(@bookings) do |booking|
  json.extract! booking, :id, :user_id, :name, :ddate, :ldate, :bdate, :ldate, :auslieferung
  json.url booking_url(booking, format: :json)
end
