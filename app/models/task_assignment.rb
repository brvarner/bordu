class TaskAssignment < ApplicationRecord
  belongs_to :user_id
  belongs_to :task_id
end
