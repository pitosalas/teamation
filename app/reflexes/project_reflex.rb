class ProjectReflex < ApplicationReflex
  before_reflex do
    @course = Course.find(element.dataset[:course_id])
    @project = Project.find(element.dataset[:project_id])
    @user = Professor.find(element.dataset[:user_id])
  end

  def archive
    @project.update(is_active: false)
    Vote.where(vote_first: @project.id).each do |v|
      v.update(vote_first: -1)
    end
    Vote.where(vote_second: @project.id).each do |v|
      v.update(vote_second: -1)
    end
    Vote.where(vote_third: @project.id).each do |v|
      v.update(vote_third: -1)
    end
  end

  def unarchive
    @project.update(is_active: true)
  end

end
