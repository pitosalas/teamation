class Group < ApplicationRecord
  belongs_to :course
  # has_many :students, through: :in_groups

  def find_group_by_student student_id
    students_id.each do |s_id|
      if s_id == student_id
        return id
      end
    end
    nil
  end
end
