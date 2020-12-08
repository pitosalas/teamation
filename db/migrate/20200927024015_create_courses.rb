class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :pin, null: false
      t.integer :professor_id, null: false
      t.boolean :has_project, default: false
      t.integer :maximum_group_member
      t.integer :minimum_group_member
      t.boolean :has_group, default: false
      t.boolean :is_voting, default: false
      
      t.timestamps
    end
  end
end
