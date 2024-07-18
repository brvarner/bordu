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
require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
