class AddMessageIdToTaskUpdates < ActiveRecord::Migration[7.1]
  def change
    add_column :task_updates, :message_id, :integer
    add_index :task_updates, :message_id
  end
end
