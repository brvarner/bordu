class Task < ApplicationRecord
  belongs_to :project_id
  belongs_to :creator_id
end
