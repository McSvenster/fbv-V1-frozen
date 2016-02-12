json.array!(@companies) do |company|
  json.extract! company, :id, :name, :user_id, :booking_id, :strasse, :hnr, :plz, :ort, :tel, :email
  json.url company_url(company, format: :json)
end
