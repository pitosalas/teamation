# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(1..60).each do
  first = Faker::Name.first_name
  last = Faker::Name.last_name
  User.create(firstname: first,
                     lastname: last,
                     email: last + "@brandeis.edu",
                     password: "password", type: "Student")

end

(1..20).each do
  first = Faker::Name.first_name
  last = Faker::Name.last_name
  User.create(firstname: first,
                  lastname: last,
                  email: last + "@brandeis.edu",
                  password: "password", type: "Professor")

end

#Create an admin student for development use
admin_student = User.create(firstname: "student_admin", lastname: "admin",
                               email: "student_admin@admin.com",
                               password: "password",
                               type: "Student")

#Create an admin professor for development use
admin_professor = User.create(firstname: "admin",
                                   lastname: "admin",
                                   email: "admin@admin.com",
                                   password: "password",
                                   type: "Professor")

#Create 10 courses taught by the admin for demo use
10.times do
  Course.create(name: Faker::Educator.course_name,
                    pin: Faker::Number.number(digits: 6),
                    professor_id: admin_professor.id)
end

#Create a consistent course taught by the admin professor for demo use
Course.create(name: Faker::Educator.course_name,
                                  pin: 111111, professor_id: admin_professor.id)

#Add 30 courses into the database
30.times do
  Course.create(name: Faker::Educator.course_name,
                    pin: Faker::Number.number(digits: 6),
                    professor_id: Professor.all.sample.id)
end

#Add 30 projects into database
30.times do
  Project.create(course_id: Course.all.sample.id,
               project_name: Faker::Team.name, description: Faker::Game.genre)
end

#Add 60 groups into the database
# 60.times do
#   Group.create(course_id: Course.all.sample.id,
#                    project_id: Project.all.sample.id, description: Faker::Game.genre)
# end

#Add 4 groups into each of the professor's classes for demo purposes
Course.where(professor_id: admin_professor.id).each do |course|
  projects = Project.where(course_id: course.id)
  4.times do
    Group.create(course_id: course.id, project_id: projects.all.sample.id, description: Faker::Game.genre)
  end
end

#Add 30 students into the admin professor's courses for demo uses
# 100.times do
#   courses = Course.where(professor_id: admin_professor.id)
#   n = courses.all.sample.id
#   s = Student.all.sample.id
#   Taking.create(student_id: s, course_id: n)
# end

#Enroll random students in a random class 200 times
# 200.times do
#   n = Course.all.sample.id
#   s = Student.all.sample.id
#   Taking.create(student_id: s, course_id: n)
# end

#Add a preference for each student in all of the admin professor's
#courses for demo purposes
# admin_professor.courses.each do |course|
#   groups = course.groups.pluck(:id)
#   if groups.size > 2
#     students = course.students
#     students.each do |student|
#       first = groups.sample
#
#       second = groups.sample
#       while (first == second)
#         second = groups.sample
#       end
#
#       third = groups.sample
#       while (third == first || third == second)
#         third = groups.sample
#       end
#       p = Preference.create(course_id: course.id,
#                             student_id: student.id,
#                             first: first,
#                             second: second,
#                             third: third,
#                             codingProficiency: 5,
#                             dreampartner: students.sample.id,
#                             schedule: "{\"mondayD\":\"0\",\"mondayN\":\"1\",\"tuesdayD\":\"1\",\"tuesdayN\":\"0\",\"wednesdayD\":\"0\",\"wednesdayN\":\"0\",\"thursdayD\":\"1\",\"thursdayN\":\"0\",\"fridayD\":\"0\"
#                                     ,\"fridayN\":\"1\",\"saturdayD\":\"0\",\"saturdayN\":\"0\",\"sundayD\":\"0\",\"sundayN\":\"0\"}")
#     end
#   end
# end
