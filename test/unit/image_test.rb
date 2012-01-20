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
#  image_path   :string(255)
#

require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end
end
