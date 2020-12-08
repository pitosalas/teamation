class AddCourseIdToInGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :in_groups, :course_id, :integer
  end
end
