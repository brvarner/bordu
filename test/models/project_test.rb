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
require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
