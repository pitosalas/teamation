require 'test_helper'

class CreateProfessorTest < ActionDispatch::IntegrationTest
    test "can create professor account" do
        get new_professor_registration_url
        assert_response :success
        post professor_registration_url, params: {professor: {email: "professor1@brandeis.edu", firstname: "admin", 
                                                  lastname: "admin", password: "password", password_confirmation: "password", type: "Professor"}}
        assert_response :redirect
        follow_redirect! 
    end

end