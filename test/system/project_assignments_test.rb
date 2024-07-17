require "application_system_test_case"

class ProjectAssignmentsTest < ApplicationSystemTestCase
  setup do
    @project_assignment = project_assignments(:one)
  end

  test "visiting the index" do
    visit project_assignments_url
    assert_selector "h1", text: "Project assignments"
  end

  test "should create project assignment" do
    visit project_assignments_url
    click_on "New project assignment"

    fill_in "Project id", with: @project_assignment.project_id_id
    fill_in "User id", with: @project_assignment.user_id_id
    click_on "Create Project assignment"

    assert_text "Project assignment was successfully created"
    click_on "Back"
  end

  test "should update Project assignment" do
    visit project_assignment_url(@project_assignment)
    click_on "Edit this project assignment", match: :first

    fill_in "Project id", with: @project_assignment.project_id_id
    fill_in "User id", with: @project_assignment.user_id_id
    click_on "Update Project assignment"

    assert_text "Project assignment was successfully updated"
    click_on "Back"
  end

  test "should destroy Project assignment" do
    visit project_assignment_url(@project_assignment)
    click_on "Destroy this project assignment", match: :first

    assert_text "Project assignment was successfully destroyed"
  end
end
