class ProjectReflex < ApplicationReflex
  before_reflex do
    @course = Course.find(element.dataset[:course_id])
    @project = Project.find(element.dataset[:project_id])
    @user = Professor.find(element.dataset[:user_id])
  end

  def archive
    @project.update(is_active: false)
  end

  def unarchive
    @project.update(is_active: true)
  end

end
