json.array!(@markers) do |marker|
  json.extract! marker, :id, :label, :position
  json.url marker_url(marker, format: :json)
end
