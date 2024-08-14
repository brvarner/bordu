json.extract! task, :id, :project_id, :title, :description, :creator_id, :completed_at, :created_at, :updated_at
json.url project_task_url(task.project_id, task, format: :json)
