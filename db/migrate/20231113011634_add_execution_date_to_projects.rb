class AddExecutionDateToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :execution_date, :date
  end
end
