class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :kana, null: false
      t.string :email, null: false
      t.integer :role, null: false
      t.string :tel, null: false
      t.string :password, null: false
      t.string :password_confirmation, null: false

      t.string :uid, null: false, default: ""
      t.datetime :discarded_at
      t.datetime :last_sign_in_at
      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
