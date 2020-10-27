class AddCurrentCourseIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :current_course_id, :integer
  end
end
