json.array!(@deliveryoptions) do |deliveryoption|
  json.extract! deliveryoption, :id, :option
  json.url deliveryoption_url(deliveryoption, format: :json)
end
