require "application_system_test_case"

class PreferencesTest < ApplicationSystemTestCase
  setup do
    @preference = preferences(:one)
  end

  test "visiting the index" do
    visit preferences_url
    assert_selector "h1", text: "Preferences"
  end

  test "creating a Preference" do
    visit preferences_url
    click_on "New Preference"

    fill_in "Course", with: @preference.course_id
    fill_in "Dream partner", with: @preference.dream_partner
    fill_in "Schedule", with: @preference.schedule
    fill_in "Student", with: @preference.student_id
    fill_in "Subject matter proficiency", with: @preference.subject_matter_proficiency
    fill_in "Time zone", with: @preference.time_zone
    click_on "Create Preference"

    assert_text "Preference was successfully created"
    click_on "Back"
  end

  test "updating a Preference" do
    visit preferences_url
    click_on "Edit", match: :first

    fill_in "Course", with: @preference.course_id
    fill_in "Dream partner", with: @preference.dream_partner
    fill_in "Schedule", with: @preference.schedule
    fill_in "Student", with: @preference.student_id
    fill_in "Subject matter proficiency", with: @preference.subject_matter_proficiency
    fill_in "Time zone", with: @preference.time_zone
    click_on "Update Preference"

    assert_text "Preference was successfully updated"
    click_on "Back"
  end

  test "destroying a Preference" do
    visit preferences_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Preference was successfully destroyed"
  end
end
