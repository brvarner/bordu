json.extract! task_assignment, :id, :user_id, :task_id, :created_at, :updated_at
json.url task_assignment_url(task_assignment, format: :json)
