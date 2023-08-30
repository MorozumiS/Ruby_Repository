class CreateLostStorages < ActiveRecord::Migration[6.1]
  def change
    create_table :lost_storages do |t|
      t.string :name, null: false
      t.string :reception_number_prefix, null: false

      t.timestamps

      t.references :project, foreign_key: true

    end

  end
end
