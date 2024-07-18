# == Schema Information
#
# Table name: task_assignments
#
#  id         :bigint           not null, primary key
#  user_id    :integer
#  task_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TaskAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :task
end
