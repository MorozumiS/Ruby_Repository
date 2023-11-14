class AddLostItemImageToLostItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :lost_items, :lost_item_image, null: false
    rename_column :lost_items, :place, :lost_spot
  end
end
