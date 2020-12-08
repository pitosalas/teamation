class CreateInGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :in_groups do |t|
      t.integer :group_id
      t.integer :student_id

      t.timestamps
    end
  end
end
