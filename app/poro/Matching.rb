require 'json'
require 'cmath'

class Matching

  def matched_groups
    @matched_groups
  end

  def add_students(students)
    @students = students
  end

  def add_projects(projects)
    @projects = projects
  end

  def add_votes(votes)
    @votes = votes
  end

  def add_professor_preferences(professor_preferences)
    @professor_preferences = professor_preferences
  end

  def initProjects(projects, votes, students, course)
    add_projects(projects)
    add_students(students)
    add_votes(votes)
    @course = course
  end
end