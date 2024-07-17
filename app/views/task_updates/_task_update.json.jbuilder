json.extract! task_update, :id, :task_id_id, :author_id_id, :body, :created_at, :updated_at
json.url task_update_url(task_update, format: :json)
