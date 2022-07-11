class AddThumbnailToItem < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :thumbnail_id, :string
  end
end
