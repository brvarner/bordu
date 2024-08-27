class AddUserEmailToTaskAssignment < ActiveRecord::Migration[7.1]
  def change
    add_column :task_assignments, :user_email, :string
  end
end
