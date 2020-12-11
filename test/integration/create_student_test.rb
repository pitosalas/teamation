require 'test_helper'

class CreateStudentTest < ActionDispatch::IntegrationTest
    test "can create professor account" do
        get new_student_registration_url
        assert_response :success
        post student_registration_url, params: {student: {email: "student1@brandeis.edu", firstname: "admin", 
                                                  lastname: "admin", password: "password", password_confirmation: "password", type: "Student"}}
        assert_response :redirect
        follow_redirect! 
    end

end