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
  belongs_to :user, foreign_key: :creator_id

  has_many :tasks
  has_many :project_assignments
end
