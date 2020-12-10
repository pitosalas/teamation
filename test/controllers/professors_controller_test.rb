require 'test_helper'

class ProfessorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/professors/sign_in'
    sign_in users(:one)
    post professor_session_url
    @professor = users(:one)
  end

  test "should get index" do
    get professors_url
    assert_response :success
  end

  test "should get new" do
    sign_out users(:one)
    get new_professor_registration_url
    assert_response :success
  end

  # test "should create professor" do
  #   assert_difference('Professor.count') do
  #     post professor_registration_url, params: {:user=> {email: "professor@brandeis.edu", firstname: "admin", 
  #                                                 lastname: "admin", password: "password", password_confirmation: "password", type: "Professor"}}
  #   end

  #   # assert_redirected_to professor_url(Professor.last)
  # end
end
