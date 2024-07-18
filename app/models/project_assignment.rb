# == Schema Information
#
# Table name: project_assignments
#
#  id         :bigint           not null, primary key
#  user_id    :integer
#  project_id :integer
#  role       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ProjectAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :project
end
