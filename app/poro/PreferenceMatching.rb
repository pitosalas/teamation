class PreferenceMatching < Matching
  def initAndPreferenceMatch(projects, students, course, preferences, professor_preferences)
    add_projects(projects)
    add_students(students)
    add_preferences(preferences)
    add_professor_preferences(professor_preferences)
    @course = course
    preference_algorithm()
  end

  def random_match()
    @group_size_min = @course.minimum_group_member
    @group_size_max = @course.maximum_group_member
    result = {}
    @projects.each do |p|
      result[p] = []
    end
    #(1)populate the result hash by assigning students's first choice
    @students.each do |s|
      project = @projects.sample
      project = @projects.sample while result[project].size >= @group_size_max
      result[project] << s
    end
    @matched_groups = result
    puts @matched_groups
  end
  
  def preference_algorithm
    random_match()
    initial_team = @matched_groups
    result = initial_team
    if result.keys.size == 1
      return result
    end
    @preferences_hash = convertAH_toHH()
    highest_score = get_score(result)
    swap_history = []
    swap_history << initial_team
    index = 0
    while index < @preferences.size
      temp_formation = swap_member(result)
      if duplicate(temp_formation, swap_history)
        index += 1
        next
      end
      swap_history << temp_formation
      temp_score = get_score(temp_formation)
      if temp_score > highest_score
        result = temp_formation
        highest_score = temp_score
      end
      index += 1
    end
    @matched_groups = result
  end

  def duplicate(team, history)
    return false
  end

  def check_for_empty_teams(teams, team)
    student1_index = nil
    unless teams[team].size.zero?
      student1_index = rand(teams[team].size)
    end
    return student1_index
  end

  def swap_member(team)
    team1 = team.keys.sample
    team2 = team.keys.sample
    team2 = team.keys.sample while team1 == team2
    student1_index = check_for_empty_teams(team, team1)
    student2_index = check_for_empty_teams(team, team2)
    temp = student1_index.nil? ? nil : team[team1][student1_index]
    if student2_index.nil?
      team[team1] = []
    else
      if student1_index.nil?
        team[team1] << team[team2][student2_index]
      else
        team[team1][student1_index] = team[team2][student2_index]
      end
    end
    if temp.nil?
      team[team2] = []
    else
      if student2_index.nil?
        team[team2] << temp
      else
        team[team2][student2_index] = temp
      end
    end
    return team
  end

  # This will convert an array of hash of preferences into a hash of hash,
  # In the form of {id: {:first, :second, :third }}
  def convertAH_toHH()
    h = {}
    @preferences.each do |x|
      key = x[:student_id]
      value = x
      h[key] = value
    end
    return h
  end

  def get_score(formation)
    lowest_score = Float::MAX
    formation.each do |project_id, teamArr|
      score = @professor_preferences[:schedule] * get_schedule_score(teamArr) +
          @professor_preferences[:subject_proficiency] * get_subject_proficiency_score(teamArr)
      + @professor_preferences[:dream_partner] * get_partner_score(teamArr)
      + @professor_preferences[:time_zone] * get_time_zone_score(teamArr)
      if score < lowest_score
        lowest_score = score
      end
    end
    return lowest_score
  end

  def get_schedule_score(teamArr)
    #initalize a team counter hash
    team_calendar = {}
    team_calendar["mondayM"]=0
    team_calendar["mondayA"]=0
    team_calendar["mondayE"]=0
    team_calendar["tuesdayM"]=0
    team_calendar["tuesdayA"]=0
    team_calendar["tuesdayE"]=0
    team_calendar["wednesdayM"]=0
    team_calendar["wednesdayA"]=0
    team_calendar["wednesdayE"]=0
    team_calendar["thursdayM"]=0
    team_calendar["thursdayA"]=0
    team_calendar["thursdayE"]=0
    team_calendar["fridayM"]=0
    team_calendar["fridayA"]=0
    team_calendar["fridayE"]=0
    team_calendar["saturdayM"]=0
    team_calendar["saturdayA"]=0
    team_calendar["saturdayE"]=0
    team_calendar["sundayM"]=0
    team_calendar["sundayA"]=0
    team_calendar["sundayE"]=0

    teamArr.each do |student|
      schedule = @preferences_hash[student][:schedule]
      schedule.delete!("\n")
      schedule_J = JSON.parse(schedule)
      puts schedule_J
      schedule_J.each do |day|
        puts day
        team_calendar[day.to_s] += 1
      end
    end

    counter = 0
    team_calendar.each do |time,team_c|
      if team_c / teamArr.size == 1
        counter += 1
      end
    end

    if counter < 1
      return -1
    else
      return (Math.log(counter.to_f/21 + 0.5) - Math.log(0.5)) / Math.log(2 + counter.to_f/21)
    end
  end

  def get_subject_proficiency_score(teamArr)
    response = []
    teamArr.each do |x|
      response << @preferences_hash[x][:subject_proficiency]
    end
    response.uniq()
    puts "subject score"
    puts response.size / 5.0
    return response.size / 5.0
  end

  def get_partner_score(teamArr)
    counter = 0
    teamArr.each do |x|
      partners = @preferences_hash[x][:dream_partner]
      if partners.nil?
        next
      end
      partners.each do |p|
        if teamArr.include? p
          counter += 1
        end
      end
    end
    puts "partner score"
    puts counter.to_f / teamArr.size
    return counter.to_f / teamArr.size
  end

  def get_time_zone_score(teamArr)
    # pair up every two students in the array
    pairs = []
    for i in 0..teamArr.length - 1
      for j in i+1..teamArr.length - 1
        if teamArr[i] != teamArr[j]
          pairs << [teamArr[i], teamArr[j]]
        end
      end
    end
    # calculate their time zone difference to get scores
    counter = 0
    pairs.each do |s_1, s_2|
      time_1 = Time.zone.now.in_time_zone(@preferences_hash[s_1][:time_zone])
      time_2 = Time.zone.now.in_time_zone(@preferences_hash[s_2][:time_zone])
      time_difference_in_seconds = time_2.utc_offset - time_1.utc_offset
      time_difference_in_hours = (time_difference_in_seconds / 60 / 60).abs
      if time_difference_in_hours <= 1
        counter += 4
      elsif time_difference_in_hours <= 2
        counter += 2
      elsif time_difference_in_hours <= 3
        counter += 1
      elsif time_difference_in_hours <= 5
        counter -= 1
      elsif time_difference_in_hours <= 6
        counter -= 2
      else
        counter -= 4
      end
    end
    puts "time zone score"
    puts counter.to_f / teamArr.size
    return counter.to_f / teamArr.size
  end
end