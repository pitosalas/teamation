class CreateTakings < ActiveRecord::Migration[6.0]
  def change
    create_table :takings do |t|
      t.integer :student_id, null: false
      t.integer :course_id, null: false

      t.timestamps
    end
  end
end
