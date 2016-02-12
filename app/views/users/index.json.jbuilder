json.array!(@users) do |user|
  json.extract! user, :id, :email, :vname, :nname, :password_digest, :strasse, :ort, :tel, :role
  json.url user_url(user, format: :json)
end
