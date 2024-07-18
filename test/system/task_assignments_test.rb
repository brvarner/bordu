require "application_system_test_case"

class TaskAssignmentsTest < ApplicationSystemTestCase
  setup do
    @task_assignment = task_assignments(:one)
  end

  test "visiting the index" do
    visit task_assignments_url
    assert_selector "h1", text: "Task assignments"
  end

  test "should create task assignment" do
    visit task_assignments_url
    click_on "New task assignment"

    fill_in "Task id", with: @task_assignment.task_id
    fill_in "User id", with: @task_assignment.user_id
    click_on "Create Task assignment"

    assert_text "Task assignment was successfully created"
    click_on "Back"
  end

  test "should update Task assignment" do
    visit task_assignment_url(@task_assignment)
    click_on "Edit this task assignment", match: :first

    fill_in "Task id", with: @task_assignment.task_id
    fill_in "User id", with: @task_assignment.user_id
    click_on "Update Task assignment"

    assert_text "Task assignment was successfully updated"
    click_on "Back"
  end

  test "should destroy Task assignment" do
    visit task_assignment_url(@task_assignment)
    click_on "Destroy this task assignment", match: :first

    assert_text "Task assignment was successfully destroyed"
  end
end
