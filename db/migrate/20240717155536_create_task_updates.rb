class CreateTaskUpdates < ActiveRecord::Migration[7.1]
  def change
    create_table :task_updates do |t|
      t.integer :task_id
      t.integer :author_id
      t.text :body

      t.timestamps
    end

      add_foreign_key :task_updates, :tasks, column: :task_id
      add_foreign_key :task_updates, :users, column: :author_id
  end
end
