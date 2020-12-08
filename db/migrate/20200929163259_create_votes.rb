class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.integer :student_id, null: false
      t.integer :course_id, null: false
      t.integer :vote_first, default: -1
      t.integer :vote_second, default: -1
      t.integer :vote_third, default: -1

      t.timestamps
    end
  end
end
