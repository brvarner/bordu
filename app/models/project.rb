# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  complete    :boolean
#  creator_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Project < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  belongs_to :creator, class_name: :User, foreign_key: :creator_id
  has_many :tasks
  has_many :task_assignments, through: :tasks, source: :assignments
  has_many :assigned_users, through: :task_assignments, source: :user
end
