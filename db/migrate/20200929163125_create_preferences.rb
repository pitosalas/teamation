class CreatePreferences < ActiveRecord::Migration[6.0]
  def change
    create_table :preferences do |t|
      t.integer :student_id, null: false
      t.integer :course_id, null: false
      t.integer :subject_matter_proficiency
      t.interval :time_zone
      t.string :dream_partner, array: true, default: []
      t.string :schedule

      t.timestamps
    end
  end
end
