require 'test_helper'

class PreferencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = courses(:one)
    @preference = preferences(:one)
  end

  test "should get index" do
    get course_preferences_url(@course.id)
    assert_template "preferences/index"
  end

  test "should get new" do
    get new_course_preference_url(@course.id)
    assert_template "preferences/new"
  end

  test "should show preference" do
    get course_preference_url(@course.id, @preference.id)
    assert_template "preferences/show"
  end

  test "should get edit" do
    get edit_course_preference_url(@course.id, @preference.id)
    assert_template "preferences/edit"
  end

end
