require 'test_helper'

class CreateProfessorAndCreateCourseTest < ActionDispatch::IntegrationTest
    test "can create professor account and create course" do
        get new_professor_registration_url
        assert_response :success
        post professor_registration_url, params: {professor: {email: "professor2@brandeis.edu", firstname: "admin", 
                                                  lastname: "admin", password: "password", password_confirmation: "password", type: "Professor"}}
        assert_response :redirect

        get add_course_professor_url(users(:one))
        assert_response :success
    end

end