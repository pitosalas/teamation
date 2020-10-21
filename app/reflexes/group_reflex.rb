class GroupReflex < ApplicationReflex

  def switch
    id = session[:group] = element[:value]
    @group = Group.find(id)
  end

  def deleteMember
    @group = Group.where(id: element.dataset["group_id"]).first
    students = @group.students_id
    students -= [element.dataset["student_id"].to_i]
    @group.update(students_id: students)
  end

  def dismissGroup
    @group = Group.find(element.dataset["group_id"])
    @group.destroy
  end

  # def moveMember
  #   deleteMember
  #   id = session[:single_group] = element[:value]
  #   @new_group = Group.find(id)
  #   students_id = @new_group.students_id
  #   students_id << student
  #   @new_group.update(students_id)
  # end
end
