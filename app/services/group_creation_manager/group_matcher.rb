module GroupCreationManager
  class GroupMatcher

      def getProjects(course)
        projects = []
        course.projects.each do |project|
          if project.is_active
            projects << project.id
          end
        end
        return projects
      end

      def getStudents(course)
        students = []
        course.students.each do |student|
          course.students.each do |student|
            students << student.id
          end
        end
        return students
      end

      def getStudentsAndProjects(course)
        students = getStudents(course)
        projects = getProjects(course)
        return students, projects
      end

      def getVotes(course)
        votes = []
        course.votes.each do |vote|
          vote_hash = {student_id: vote.student_id, vote_first: vote.vote_first,
                       vote_second: vote.vote_second, vote_third: vote.vote_third}
          votes << vote_hash
        end
        return votes
      end

      def assign_groups(groups_hash, course)
        group_index = 1
        groups_hash.each do |project, students|
          Group.create!(course_id: course.id, project_id: project, group_name: "group #{group_index}", students_id:students)
          group_index = group_index + 1
        end
      end

      def determine_algo_and_match(course, params)
        students, projects = getStudentsAndProjects(course)
        votes = getVotes(course)
        algorithm = params[:algo]
        if algorithm == "project_only"
          matching_object = ProjectMatching.new
          matching_object.initAndProjectMatch(projects, votes, students, course)
        end
        assign_groups(matching_object.matched_groups, course)
      end
  end
end