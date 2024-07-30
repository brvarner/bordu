# == Schema Information
#
# Table name: task_updates
#
#  id         :bigint           not null, primary key
#  task_id    :integer
#  author_id  :integer
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :integer
#
class TaskUpdate < ApplicationRecord
  belongs_to :task
  belongs_to :user, foreign_key: :author_id
end
