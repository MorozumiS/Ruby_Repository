class CreateLostItems < ActiveRecord::Migration[6.1]
  def change
    create_table :lost_items do |t|
      t.string :name, null: false
      t.string :place, null: false
      t.string :comment
      t.string :owner_name
      t.string :owner_tel
      t.string :owner_address
      t.string :features

      t.datetime :discarded_at

      t.timestamps

      t.references :lost_storage, foreign_key: true
      t.references :project, foreign_key: true

    end
  end
end
