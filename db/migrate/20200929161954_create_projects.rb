class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :project_name
      t.integer :course_id, null: false
      t.text :description
      t.boolean :is_active, default: false
      t.integer :number_of_likes, default: 0

      t.timestamps
    end
  end
end
