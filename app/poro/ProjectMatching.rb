class ProjectMatching < Matching

  def initAndProjectMatch(projects, votes, students, course)
    initProjects(projects, votes, students, course)
    match()
  end

  def match()
    @group_size_min = @course.minimum_group_member
    @group_size_max = @course.maximum_group_member
    result = {}
    @projects.each do |p|
      result[p] = []
    end
    puts @projects
    #(1)populate the result hash by assigning students's first choice
    puts @votes
    @votes.each do |v|
      temp_project_choice = v[:vote_first]
      result[temp_project_choice] << v[:student_id]
    end
    puts "assigning everyone to their first choice"
    puts result
    result = move_people(result)
    @matched_groups = result
    puts "getting result"
    puts @matched_groups
  end

  # loop through to make sure all groups have equal size
  def move_people(result)
    puts "moving people"
    index = 0
    while index < @projects.length do
      # find the most popular project, and move out those people whose second choice group has not been fulfilled
      most_popular_project = find_most_popular_project(result)
      if result[most_popular_project].length > @group_size_max then
        popular_group_size = result[most_popular_project].length - 1
        puts "votes"
        puts @votes
        while (result[most_popular_project].length > @group_size_max && popular_group_size >= 0)
          unlucky_student = result[most_popular_project][popular_group_size]
          puts "unlucky_student"
          puts unlucky_student
          second_choice = @votes.find { |vote| vote[:student_id] == unlucky_student}[:vote_second]
          if result[second_choice].length < @group_size_max then
            result[most_popular_project].delete(unlucky_student)
            result[second_choice] << unlucky_student
          end
          popular_group_size = popular_group_size - 1
          puts "moved to second"
          puts result
        end
      end

      # find the most popular project, and move out those people whose third choice group has not been fulfilled
      if result[most_popular_project].length > @group_size_max then
        popular_group_size = result[most_popular_project].length - 1
        while (result[most_popular_project].length > @group_size_max && popular_group_size >= 0)
          unlucky_student = result[most_popular_project][popular_group_size]
          puts "unlucky_student for third choice"
          puts unlucky_student.nil?
          third_choice = @votes.find { |vote| vote[:student_id] == unlucky_student}[:vote_third]
          if (result[third_choice].length < @group_size_max) then
            result[most_popular_project].delete(unlucky_student)
            result[third_choice] << unlucky_student
          end
          popular_group_size = popular_group_size - 1
        end
      end

      #if the group is still overpopulated, use random algo to move students out
      while result[most_popular_project].length > @group_size_max
        poor_student = result[most_popular_project].delete(result[most_popular_project].sample)
        result[result.find{ |key, value| key != most_popular_project && value.length <= @group_size_min }[0]] << poor_student
      end
      index = index + 1
    end

    # check if a group has too little students
    unfilled = result.find{ |key, value| value.length < @group_size_min}
    while (!unfilled.nil?) do
      most_p = find_most_popular_project(result)
      poor_student = result[most_p].delete_at(result[most_p].size - 1)
      result[unfilled[0]] << poor_student
      unfilled = result.find{|key, value| value.length < @group_size_min}
    end

    return result
  end

  def find_most_popular_project result
    most_popular_project = result.keys.sample
    result.each do |project, n_members|
      if n_members.length > result[most_popular_project].length then
        most_popular_project = project
      end
    end
    puts "most popular project"
    puts most_popular_project
    return most_popular_project
  end


end


