class HolisticMatching < ProjectMatching

  def initAndHolisticMatch(projects, preferences, professor_preferences)
    initProjects(projects, preferences)
    add_professor_preferences(professor_preferences)
    holistic_algorithm()
  end

  def holistic_algorithm
    match()
    initial_team = @matched_groups
    result = initial_team
    if result.keys.size == 1 then
      return result
    end
    @preferences_hash = convertAH_toHH()
    highest_score = get_score(result)
    swap_history = []
    swap_history << initial_team
    index = 0
    while index < @preferences.size do
      temp_formation = swap_member(result)
      if duplicate(temp_formation, swap_history) then
        index = index + 1
        next
      end
      swap_history << temp_formation
      temp_score = get_score(temp_formation)
      if temp_score > highest_score then
        result = temp_formation
        highest_score = temp_score
      end
      index = index + 1
    end
    @matched_groups = result
  end

  def duplicate(team, history)
    return false
  end

  def check_for_empty_teams(teams, team)
    if teams[team].size == 0
      return student1_index = nil
    else
      return student1_index = rand(teams[team].size)
    end
  end

  def swap_member(team)
    team1 = team.keys.sample
    team2 = team.keys.sample
    while team1 == team2 do
      team2 = team.keys.sample
    end
    student1_index = check_for_empty_teams(team, team1)
    student2_index = check_for_empty_teams(team, team2)
    if student1_index.nil?
      temp = nil
    else
      temp = team[team1][student1_index]
    end
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
      + @professor_preferences[:time_zone] * get_time_zone_score(teamArr) +
      @professor_preferences[:project] * get_project_score(teamArr, proj_id)
      if socre < lowest_score then
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
    team_calendar["mondayN"]=0
    team_calendar["tuesdayM"]=0
    team_calendar["tuesdayA"]=0
    team_calendar["tuesdayN"]=0

    teamArr.each do |student|
      schedule = @preferences_hash[student][:schedule]
      # schedule = schedule_string[student]
      schedule.delete!("\n")
      schedule_J = JSON.parse(schedule)
      schedule_J.each do |key,value|
        team_calendar[key]+= value.to_i
      end
    end

    counter=0
    team_calendar.each do |time,team_c|
      if(team_c/teamArr.size == 1) then
        counter +=1
      end
    end

    if (counter<1) then
      return -1
    else
      return (Math.log(counter.to_f/14+0.5)-Math.log(0.5))/Math.log(2+counter.to_f/14)
    end
  end
end
