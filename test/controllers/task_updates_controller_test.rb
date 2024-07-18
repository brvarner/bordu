require "test_helper"

class TaskUpdatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_update = task_updates(:one)
  end

  test "should get index" do
    get task_updates_url
    assert_response :success
  end

  test "should get new" do
    get new_task_update_url
    assert_response :success
  end

  test "should create task_update" do
    assert_difference("TaskUpdate.count") do
      post task_updates_url, params: { task_update: { author_id: @task_update.author_id, body: @task_update.body, task_id: @task_update.task_id } }
    end

    assert_redirected_to task_update_url(TaskUpdate.last)
  end

  test "should show task_update" do
    get task_update_url(@task_update)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_update_url(@task_update)
    assert_response :success
  end

  test "should update task_update" do
    patch task_update_url(@task_update), params: { task_update: { author_id: @task_update.author_id, body: @task_update.body, task_id: @task_update.task_id } }
    assert_redirected_to task_update_url(@task_update)
  end

  test "should destroy task_update" do
    assert_difference("TaskUpdate.count", -1) do
      delete task_update_url(@task_update)
    end

    assert_redirected_to task_updates_url
  end
end
