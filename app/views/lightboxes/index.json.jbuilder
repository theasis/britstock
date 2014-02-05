json.array!(@lightboxes) do |lightbox|
  json.extract! lightbox, :id, :name, :description, :photographer_id, :istockid, :exampleimage
  json.url lightbox_url(lightbox, format: :json)
end
