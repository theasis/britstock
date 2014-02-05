json.array!(@photographers) do |photographer|
  json.extract! photographer, :id, :name, :description, :website, :phone, :email, :istock_name, :istock_userid, :password, :city, :country
  json.url photographer_url(photographer, format: :json)
end
