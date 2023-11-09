class AddDeleteFlgToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :delete_flg, :boolean, default: false, null: false
  end
end
