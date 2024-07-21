# == Schema Information
#
# Table name: tasks
#
#  id           :bigint           not null, primary key
#  project_id   :integer
#  title        :string
#  description  :text
#  creator_id   :integer
#  completed_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  status       :string
#
class Task < ApplicationRecord
  belongs_to :project
  belongs_to :creator, class_name: :User

  has_many :task_assignments
  has_many :task_updates
end
