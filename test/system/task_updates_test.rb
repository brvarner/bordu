require "application_system_test_case"

class TaskUpdatesTest < ApplicationSystemTestCase
  setup do
    @task_update = task_updates(:one)
  end

  test "visiting the index" do
    visit task_updates_url
    assert_selector "h1", text: "Task updates"
  end

  test "should create task update" do
    visit task_updates_url
    click_on "New task update"

    fill_in "Author id", with: @task_update.author_id
    fill_in "Body", with: @task_update.body
    fill_in "Task id", with: @task_update.task_id
    click_on "Create Task update"

    assert_text "Task update was successfully created"
    click_on "Back"
  end

  test "should update Task update" do
    visit task_update_url(@task_update)
    click_on "Edit this task update", match: :first

    fill_in "Author id", with: @task_update.author_id
    fill_in "Body", with: @task_update.body
    fill_in "Task id", with: @task_update.task_id
    click_on "Update Task update"

    assert_text "Task update was successfully updated"
    click_on "Back"
  end

  test "should destroy Task update" do
    visit task_update_url(@task_update)
    click_on "Destroy this task update", match: :first

    assert_text "Task update was successfully destroyed"
  end
end
