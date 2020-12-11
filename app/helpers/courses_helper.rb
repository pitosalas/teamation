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

  def find_current_user_vote_record course
    course.votes.where(student_id: current_user.id).first
  end

  def find_current_user_first_choice course
    return find_current_user_vote_record(course).vote_first
  end

  def find_current_user_second_choice course
    return find_current_user_vote_record(course).vote_second
  end

  def find_current_user_third_choice course
    return find_current_user_vote_record(course).vote_third
  end

  def find_project_name project_id
    if project_id == -1
      return "Not Voted"
    else
      project = Project.active.find(project_id)
      return project.project_name
    end
  end

  def find_first_choice_project course
    project_id = find_current_user_first_choice(course)
    return find_project_name(project_id)
  end

  def find_second_choice_project course
    project_id = find_current_user_second_choice(course)
    return find_project_name(project_id)
  end

  def find_third_choice_project course
    project_id = find_current_user_third_choice(course)
    return find_project_name(project_id)
  end
end
