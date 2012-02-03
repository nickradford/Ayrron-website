# == Schema Information
#
# Table name: images
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  description  :text
#  completed_on :date
#  gallery_id   :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Image < ActiveRecord::Base
  belongs_to :gallery
  
  has_attached_file :image, :styles => {:thumb=> "100x100#", :small  => "400x400>" }
  
  def asset_url
    image.url
  end
end
