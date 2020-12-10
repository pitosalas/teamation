require 'test_helper'

class PreferencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = courses(:one)
    # @preference = preferences(:one)
  end

  test "should get index" do
    get course_preferences_url(@course.id)
    assert_template "preferences/index"
  end

  test "should get new" do
    get new_course_preference_url(@course.id)
    assert_template "preferences/new"
  end

#   test "should create preference" do
#     assert_difference('Preference.count') do
#       post preferences_url, params: { preference: { course_id: @preference.course_id, dream_partner: @preference.dream_partner, schedule: @preference.schedule, student_id: @preference.student_id, subject_matter_proficiency: @preference.subject_matter_proficiency, time_zone: @preference.time_zone } }
#     end

#     assert_redirected_to preference_url(Preference.last)
#   end

#   test "should show preference" do
#     get preference_url(@preference)
#     assert_response :success
#   end

#   test "should get edit" do
#     get edit_preference_url(@preference)
#     assert_response :success
#   end

#   test "should update preference" do
#     patch preference_url(@preference), params: { preference: { course_id: @preference.course_id, dream_partner: @preference.dream_partner, schedule: @preference.schedule, student_id: @preference.student_id, subject_matter_proficiency: @preference.subject_matter_proficiency, time_zone: @preference.time_zone } }
#     assert_redirected_to preference_url(@preference)
#   end

#   test "should destroy preference" do
#     assert_difference('Preference.count', -1) do
#       delete preference_url(@preference)
#     end

#     assert_redirected_to preferences_url
#   end
end
