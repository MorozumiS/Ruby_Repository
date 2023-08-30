class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :place, null: false

      t.datetime :start_at
      t.datetime :end_at
      t.datetime :discarded_at

      t.timestamps

      t.references :user, foreign_key: true

    end
  end
end
