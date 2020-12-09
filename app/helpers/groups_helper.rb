module GroupsHelper

  def students_fill_preference_form? course
    all_students = course.students.map { |student| student.id }
    all_preferences = Preference.where(course_id: course.id).map { |p| p.student_id}
    return all_students.sort == all_preferences.sort
  end
end
