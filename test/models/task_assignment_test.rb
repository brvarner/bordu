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
require "test_helper"

class TaskAssignmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
