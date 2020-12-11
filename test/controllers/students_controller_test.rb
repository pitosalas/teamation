require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
    setup do
      get '/students/sign_in'
      sign_in users(:two)
      post student_session_url
      @student = users(:two)
    end
  
    test "should get index" do
      get students_url
      assert_response :success
    end
  
    test "should get new" do
      sign_out users(:two)
      get new_student_registration_url
      assert_response :success
    end
  
    test "should create student" do
      post student_registration_url, params: {email: "student@brandeis.edu", firstname: "admin", 
                                                    lastname: "admin", password: "password", password_confirmation: "password", type: "Student"}
      assert_response :redirect
      follow_redirect!                                          
      # assert_redirected_to student_url(Student.last.id)
    end
  
    test "should show student" do
      get student_url(@student)
      assert_response :success
    end
  
    test "should get edit" do
      get edit_student_url(@student)
      assert_response :success
    end
  
    test "should destroy student" do
      assert_difference('Student.count', -1) do
        delete student_registration_url(@student)
      end
  
      # assert_redirected_to students_url
    end

  
end
