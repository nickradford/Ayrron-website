ActiveAdmin.register Image do
  index do
    column :title
    column :description
    column :preview do |i|
      image_tag i.image.url, :width => 200
    end
  end
  
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :title
      f.input :description
      f.input :gallery
      f.input :image, :as => :file
    end
  end
end
