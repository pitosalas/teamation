class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.integer :course_id, null: false
      t.integer :project_id
      t.string :group_name
      t.integer :students_id, array: true, default: []

      t.timestamps
    end
  end
end
