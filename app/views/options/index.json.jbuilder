json.array!(@options) do |option|
  json.extract! option, :id, :slots
  json.url option_url(option, format: :json)
end
