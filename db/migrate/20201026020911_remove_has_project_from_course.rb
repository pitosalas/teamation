class RemoveHasProjectFromCourse < ActiveRecord::Migration[6.0]
  def change
    remove_column :courses, :has_project, :boolean
  end
end
