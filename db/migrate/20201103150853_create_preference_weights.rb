class CreatePreferenceWeights < ActiveRecord::Migration[6.0]
  def change
    create_table :preference_weights do |t|
      t.integer :course_id
      t.integer :subject_proficiency
      t.integer :dream_partner
      t.integer :time_zone
      t.integer :schedule

      t.timestamps
    end
  end
end
