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
require "test_helper"

class TaskUpdateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
