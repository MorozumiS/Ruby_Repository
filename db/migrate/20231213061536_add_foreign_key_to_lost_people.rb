class AddForeignKeyToLostPeople < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :lost_people, :users, column: :client_id, primary_key: :id
    add_index :lost_people, :client_id
  end
end
