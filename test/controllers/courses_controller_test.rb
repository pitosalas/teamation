require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/professors/sign_in'
    sign_in users(:one)
    post professor_session_url
    @course = courses(:one)
    @current_user = users(:one)
  end

  test "should get index" do
    get courses_url
    assert_response :success
  end

  test "should get new" do
    get add_course_professor_url(users(:one))
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post create_course_professor_url(@current_user.id)
    end

    assert_redirected_to professor_url(@current_user.id)
  end

  test "should show course" do
    get course_url(@course.id)
    assert_template "courses/show"
  end

  # test "should download the student example file" do
  #   get download_student_list_path
  #   find("Student List Sample CSV").click
  # end

  # test "should get edit" do
  #   get edit_course_url(@course)
  #   assert_response :success
  # end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete course_url(@course)
    end

    assert_redirected_to professor_url(@current_user.id)
  end
end
