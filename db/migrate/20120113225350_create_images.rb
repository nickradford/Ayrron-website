class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title
      t.text :description
      t.date :completed_on
      t.integer :gallery_id, :null => false

      t.timestamps
    end
  end
end
