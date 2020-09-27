class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :pin
      t.integer :professor_id
      t.boolean :has_project
      t.integer :maximum_group_member
      t.integer :minimum_group_member
      t.boolean :has_group
      t.boolean :is_voting
      
      t.timestamps
    end
  end
end
