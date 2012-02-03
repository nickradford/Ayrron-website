# == Schema Information
#
# Table name: galleries
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Gallery < ActiveRecord::Base
  has_many :images
  
  def preview_image
    images[ rand(images.size) ]
  end
end
