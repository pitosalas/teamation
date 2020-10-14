class AddUserIdToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :added_by, :integer
  end
end
