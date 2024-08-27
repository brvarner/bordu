# == Schema Information
#
# Table name: task_assignments
#
#  id         :bigint           not null, primary key
#  user_id    :integer
#  task_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_email :string
#
class TaskAssignment < ApplicationRecord
  belongs_to :task
  belongs_to :recipient, class_name: :User, foreign_key: :user_id
end
