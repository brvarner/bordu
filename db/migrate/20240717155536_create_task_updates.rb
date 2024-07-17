class CreateTaskUpdates < ActiveRecord::Migration[7.1]
  def change
    create_table :task_updates do |t|
      t.references :task_id, null: false, foreign_key: true
      t.references :author_id, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
