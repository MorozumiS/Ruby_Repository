class CreateLostPersonImages < ActiveRecord::Migration[6.1]
  def change
    create_table :lost_person_images do |t|
      t.string :content, null: false

      t.datetime :discarded_at
      t.timestamps

      t.references :lost_person, foreign_key: true
    end
  end
end
