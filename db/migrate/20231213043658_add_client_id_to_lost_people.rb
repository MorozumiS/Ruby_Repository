class AddClientIdToLostPeople < ActiveRecord::Migration[6.1]
  def change
    add_column :lost_people, :client_id, :bigint
  end
end
