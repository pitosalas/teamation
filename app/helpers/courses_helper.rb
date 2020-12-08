module CoursesHelper

  def find_student_assigned_group groups, student_id
    groups.each do |group|
      if group.students_id.include? student_id
        return group.id
      end
    end
    return nil
  end
end
