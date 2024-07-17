class TaskUpdate < ApplicationRecord
  belongs_to :task_id
  belongs_to :author_id
end
