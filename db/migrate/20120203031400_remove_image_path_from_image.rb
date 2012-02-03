class RemoveImagePathFromImage < ActiveRecord::Migration
  def up
    remove_column :images, :image_path, :string
  end

  def down
    add_column :images, :image_path, :string
  end
end
