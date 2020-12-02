module ApplicationHelper

  def full_name current_user
    return current_user.firstname + " " + current_user.lastname
  end

  def has_project? course
    return course.withProject == true
  end
  
  def at_fill_question? course
    return course.state == "fill_question"
  end
  
  def at_project_brainstorm? course
    return course.state == "project_brainstorm"
  end
  
  def at_project_voting? course
    return course.state == "project_voting"
  end
  
  def at_choose_algo? course
    return course.state == "choose_algo"
  end
  
  def at_view_groups? course
    return course.state == "view_groups"
  end

  def student_at_fill_preference? student, course
    student.takings.where(course_id: course.id).first.state == "fill_preference"
  end

  def student_at_project_brainstorm? student, course
    student.takings.where(course_id: course.id).first.state == "project_brainstorm"
  end

  def student_at_project_voting? student, course
    student.takings.where(course_id: course.id).first.state == "project_voting"
  end

  def student_at_view_groups? student, course
    student.takings.where(course_id: course.id).first.state == "view_groups"
  end

  def get_student_state student, course
    return student.takings.where(course_id: course.id).first.state
  end
  
  def find_student_group student, course
    course.groups.each do |g|
     if g.students_id.include? student.id
       return g.group_name
     end
    end
    return nil
  end

  def get_status_with_state state
    if state == "fill_question" or state == "fill_preference"
      return "Settings"
    elsif state == "project_brainstorm"
      return "Project Brainstorm"
    elsif state == "project_voting"
      return "Project Voting"
    elsif state == "choose_algo"
      return "Choose Algorithms for Groups"
    elsif state == "view_groups"
      return "Groups Created"
    else
      return "Course Created"
    end
  end
end
