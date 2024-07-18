class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.integer :project_id
      t.string :title
      t.text :description
      t.integer :creator_id
      t.datetime :completed_at

      t.timestamps
    end

    add_foreign_key :tasks, :projects, column: :project_id
    add_foreign_key :tasks, :users, column: :creator_id 
  end
end
