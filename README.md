# README

**Project Description:**

Teamation designs to make forming students into teams for a group project convenient for professors while also fair and effective for the students. 
Teamation helps faciliate the group creation process by offering two modes: creating groups with
project, or creating groups without project. It separates the process into following steps:
project brainstorm, project voting, choose one of the three algorithms for dividing groups, and
view groups. It also provides some convenient ways for professors to manage the course by enrolling all students with csv, importing all projects and description 
with csv, and exporting group zoom breakout room csv. 

Link to Heroku:
http://teamation-brandeis.herokuapp.com/

**Framework & Packages:**

* Ruby 2.6.5
* Ruby on Rails 6.0.3.4
* PostgreSQL 12
* Stimulus Reflex & ActionCable
* CSS
* HTML

**Basic commands to run:**

* cd ~/teamation
* bundle install
* rails dev:cache
* rails db:create db:migrate db:seed
* rails s

After seeding data, you can run a quick demo and try some features by logging in with following accounts:

* professor
    * username: admin_prof@brandeis.edu
    * password: password
* student
    * username: admin_student@brandeis.edu
    * password: password
    
These accounts have all data needed for trying three algorithms, please refer to the course title for which one to use.


**Core Features & Implementations:**

###### _General_
1. Log In / Sign Up (with Devise) - only allow brandeis email to log in
2. Users who forgot their passwords can reset their passwords. This function is implemented through SendGrid plugin.
3. Matching algorithm for dividing students into groups (Services/GroupCreationManager & Poro/Matcher Object for details)
* Matching based on Preference Matching
  1. randomly assigned students into projects
  2. based on students' inputs on preference forms information and professors' preference weights get group score
  3. swap members to improve group scores
* Matching based on Project Voting
  1. assign students to their first choice projects
  2. iterate to check if any first choice group exceeds maximum group member, put a random student from the group to second choice project
  3. iterate to check if any second choice group exceeds maximum group member, put a random student from the group to third choice project
  4. check if all groups have enough students
* Holistic Matching (based on both Preference and Project Voting)
  1. assign students based on project voting 
  2. based on students' inputs on preference forms, project voting and professors' preference weights get group score
  3. swap members to improve group scores
3. Keep track of current course state and last course accessed when logged in 

###### _Professor_
1. edit profile, view all courses, add a course (generate a 6 digit pin for students to use), delete a course
2. input course settings: maximum/minimum member in a group, preference weights for group creation
3. upload a csv with student name and email to enroll all students to a class (Attention: The uploaded files should be in specific formats. Please download the sample file for reference. The default password of student accounts is their password.)
4. Create Groups Based on Projects
   * Professor can upload project and its descriptions with csv. (Attention: The uploaded files should be in specific formats. Please download the sample file for reference.) 
   * Project Brainstorm: add a Project to project lists, mark projects as active projects, edit, delete projects
   * Project Voting: display onhold and active projects with number of first, second, third votes (only active projects will be used to be assigned with students)
   * Choose group division
        * Holistic Match: All students need to vote their first, second, third choice. All students need to fill their preference forms
        * Preference Match: All students need to fill preferences
        * Project Match: All students need to vote first, second, third
        * enough active projects: ceiling of number of students enrolled in course / maximum member in a group
   * View groups, dismiss all groups, export groups into csv file for zoom breakout room     
4. Create Groups without Projects
   * Only Preference Match is available in this case
   * view groups
   
###### _Student_
1. Fill preference forms: subject matter proficiency, schedule, dream partner, time zone (taken from profile)
2. course with projects
    * Project brainstorm: add a project, delete/edit a project added by the student
    * Project voting: vote first, second, third preferences
        * voting rule: 
        1. students cannot vote a single project as their first, second, and third choice
        2. students can only vote first, second, third choice once 
        3. only active projects can be voted
    * view groups if created
3.  course without projects
    * wait to be assigned & view groups

**Schema Design:**

_Users_: id, firstname, lastname, email, password, type(Student/Professor), current_course_id(keep track of last course accessed), time zone

_Courses_: id, name, pin, professor_id, maximum_group_member, minimum_group_member, has_group (whether group is created), is_voting(can be deleted later), state(for professor: created, fill_question, project_brainstorm, project_voting, choose_algo, view_groups), withProject(has project or not)

_Projects_: id, project_name, course_id, description, is_active, number_of_likes, added_by(user_id)

_Groups_: id, course_id, project_id, group_name, students_id(array of student ids)

_Preferences_: id, student_id, course_id, subject_matter_proficiency, time_zone, dream_partner(array of student ids), schedule(M => morning, A => Afternoon, E => Evening)

_Votes_: id, student_id, course_id, vote_first(project_id), vote_second, vote_third

_Preference_Weights_(weight assigned by professor to represent the importance of this field in algorithm): id, course_id, subject_proficiency, dream_partner, time_zone, schedule, project_voting

_Takings_: id, student_id, course_id, state(keep track of student's progress in each course)

**File Structure:**

* Design & Layout & Reactive App:
    * javascript/stylesheets
    * views
    * reflexes
* Data Model & Schema:
    * db/schema, seeds
    * models
* Matching Algorithm:
    * Poro
    * services/group_creation_manager
* Backend:
    * helpers
    * controllers

**Testing:**

* Unit tests:
    - There are more than 20 unit tests, which are mainly focused on testing each controller's behaviors.
* Integration tests:
    - There are integration tests, which are focused on testing the behaviors when invoking multiple controllers.
* CI with Github Actions
 
**Unsolved Issues && Improvements in the future:**

Issues:
1. After groups are created, it takes one or couple refreshes to display the result. It will show as no groups yet first.
2. There might be some edge cases with the algorithm that we are unaware of. The algorithm needs thorough testing.

Features we didn't have time to implement:
1. Professor gets notification if students edit their preference form
2. Students like a project on project brainstorm and voting page so it is easier for professors to decide which projects should be marked as active
3. Move students to different groups
4. View student tables by on different ordering (sort by first name, last name, time zone, group number/name)
5. If professors cannot create groups because some students haven't vote / haven't fill preference form, professors can get
notification of the student name or send a reminder to students
6. After professors created groups, students should be redirect to the view groups page, or get notifications about viewing groups.
7. Think about ways to make this app applicable and usable to broader users in subjects other than COSI

**Team Members:**

Nina Xu, Xiaojing Yan, Professor Pito Salas

Teamation is originally created and developed by Sam Ruditsky, Lu Zhai, Andrew Yan in Professor Sala's capstone course. Their repo can be found here: https://github.com/ditsky/team-formation-app .
