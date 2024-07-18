require "test_helper"

class TaskAssignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_assignment = task_assignments(:one)
  end

  test "should get index" do
    get task_assignments_url
    assert_response :success
  end

  test "should get new" do
    get new_task_assignment_url
    assert_response :success
  end

  test "should create task_assignment" do
    assert_difference("TaskAssignment.count") do
      post task_assignments_url, params: { task_assignment: { task_id: @task_assignment.task_id, user_id: @task_assignment.user_id } }
    end

    assert_redirected_to task_assignment_url(TaskAssignment.last)
  end

  test "should show task_assignment" do
    get task_assignment_url(@task_assignment)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_assignment_url(@task_assignment)
    assert_response :success
  end

  test "should update task_assignment" do
    patch task_assignment_url(@task_assignment), params: { task_assignment: { task_id: @task_assignment.task_id, user_id: @task_assignment.user_id } }
    assert_redirected_to task_assignment_url(@task_assignment)
  end

  test "should destroy task_assignment" do
    assert_difference("TaskAssignment.count", -1) do
      delete task_assignment_url(@task_assignment)
    end

    assert_redirected_to task_assignments_url
  end
end
