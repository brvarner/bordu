class CreateProjectAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :project_assignments do |t|
      t.integer :user_id
      t.integer :project_id
      t.string :role


      t.timestamps
    end

    add_foreign_key :project_assignments, :users, column: :user_id
    add_foreign_key :project_assignments, :projects, column: :project_id
  end
end
