module CoursesHelper

  def find_student_assigned_group groups, student_id
    groups.each do |group|
      if group.students_id.include? student_id
        return group.id
      end
    end
    return nil
  end

  def check_settings_fulfilled? course
    return course.maximum_group_member.nil? || course.minimum_group_member.nil?
  end
end
