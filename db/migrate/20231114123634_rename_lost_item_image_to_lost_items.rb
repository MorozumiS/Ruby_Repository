class RenameLostItemImageToLostItems < ActiveRecord::Migration[6.1]
  def change
    rename_column :lost_items, :place, :lost_spot
  end
end
