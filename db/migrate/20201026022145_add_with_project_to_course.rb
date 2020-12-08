class AddWithProjectToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :withProject, :boolean
  end
end
