# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'tzinfo'

def seed_student
  students = []
  (1..200).each do
    first = Faker::Name.first_name
    last = Faker::Name.last_name
    student = User.create!(firstname: first,
                       lastname: last,
                       email: last + Faker::Number.number(digits: 6).to_s + "@brandeis.edu",
                       password: "password", type: "Student", time_zone: seed_time_zone)
    students << student.id

  end
  puts "Finish seeding students"
  return students
end

def seed_prof
  profs = []
  (1..3).each do
    first = Faker::Name.first_name
    last = Faker::Name.last_name
    prof = User.create!(firstname: first,
                    lastname: last,
                    email: last + + Faker::Number.number(digits: 6).to_s + "@brandeis.edu",
                    password: "password", type: "Professor", time_zone: seed_time_zone)
    profs << prof.id
  end
  puts "Finish seeding profs"
  return profs
end


#Create 10 courses for each professor
def seed_course profs, students
  profs.each do |p|
    3.times do
      course = Course.create!(name: Faker::Educator.course_name,
                        pin: Faker::Number.number(digits: 6),
                        professor_id: p,
                    minimum_group_member: (1..3).to_a.sample,
                    maximum_group_member: (4..8).to_a.sample,
                    has_group: false,
                    is_voting: false,
                    state: "created",
                    withProject: [true, false].sample)
      30.times do
        s = students.sample
        n = 0
        while !Taking.where(student_id: s, course_id: course.id).first.nil? && n < 5
          s = students.sample
          n += 1
        end
        if Taking.where(student_id: s, course_id: course.id).first.nil?
          Taking.create!(student_id: s, course_id: course.id, state: "created")
        end
      end
      puts "30 takings created"
      projects = []
      if course.withProject
        8.times do
          r = course.students.all.sample
          added_by = nil
          unless r.nil?
            added_by = r.id
          end
          project = Project.create!(project_name: Faker::Team.name, course_id: course.id, description: Faker::Game.genre,
                                    is_active: [true, false].sample, number_of_likes: 0, added_by: added_by)
          if project.is_active
            projects << project
          end
        end
        PreferenceWeight.create(course_id: course.id, subject_proficiency: rand(5), dream_partner: rand(5), time_zone: rand(5), schedule: rand(5), project_voting: rand(5))
        puts "projects and Preference Weight created"
        course.students.each do |s|
          vote_first = projects.active.sample
          vote_second = projects.sample
          while vote_second == vote_first
            vote_second = projects.sample
          end
          vote_third = projects.sample
          while vote_second == vote_third || vote_third == vote_first
            vote_third = projects.sample
          end
          Vote.create!(student_id: s.id, course_id: course.id, vote_first: vote_first, vote_second: vote_second, vote_third: vote_third)

          # create preference form
          dream_partner = seed_partner(course.students, course.maximum_group_member)
          schedule = seed_schedule
          time_zone = s.time_zone
          Preference.create!(student_id: s.id, course_id: course.id, subject_matter_proficiency: (1..5).to_a.sample, time_zone: time_zone, dream_partner: dream_partner, schedule: schedule)
        end
        puts "votes and preferences created"
      end
    end
    puts "courses created"
  end
end

def seed_partner students, maximum
  partners = []
  random_partner_number = (0..maximum).to_a.sample
  random_partner_number.times do
    unless students.all.sample.nil?
      partners << students.all.sample.id
    end
  end
  return partners
end

def seed_schedule
  seed_schedule = []
  n = rand(5)
  schedule = ["mondayM", "mondayA", "mondayE", "tuesdayM", "tuesdayA", "tuesdayE", "wednesdayM", "wednesdayA", "wednesdayE", "thursdayM", "thursdayA", "thursdayE", "fridayM", "fridayA", "fridayE", "saturdayM", "saturdayA", "saturdayE", "sundayM", "sundayA", "sundayE"]
  n.times do
    seed_schedule << schedule.sample
  end
  return seed_schedule
end

def seed_time_zone
  return TZInfo::Timezone.all_identifiers.sample
end

students = seed_student
profs = seed_prof
seed_course(profs, students)