module GroupsHelper

  def students_fill_preference_form? course
    all_students = course.students.map { |student| student.id }
    all_preferences = Preference.where(course_id: course.id).map { |p| p.student_id}
    return all_students.sort == all_preferences.sort
  end

  def students_all_vote? course
    all_students = course.students.map { |student| student.id }
    all_students.each do |s|
      v = Vote.where(course_id: course.id, student_id: s).first
      if v.vote_first == -1 || v.vote_second == -1 || v.vote_third == -1
        return false
      end
    end
    return true
  end
end
