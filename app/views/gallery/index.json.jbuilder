json.array!(@galleries) do |json, gallery|
  json.(gallery, :id, :title, :description)

  json.images gallery.images do |json, image|
    json.(image, :id, :title, :description)
    json.image_path image.image.url
  end
end