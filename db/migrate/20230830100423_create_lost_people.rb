class CreateLostPeople < ActiveRecord::Migration[6.1]
  def change
    create_table :lost_people do |t|
      t.string :name, null: false
      t.string :kana, null: false
      t.integer :gender, null: false
      t.string :age, null: false
      t.string :tall, null: false
      t.integer :status, null: false

      t.datetime :reception_at
      t.datetime :last_sign_in_at
      t.datetime :discarded_at

      t.timestamps

      t.references :lost_storage, foreign_key: true
      t.references :project, foreign_key: true

    end
  end
end
