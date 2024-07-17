class CreateProjectAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :project_assignments do |t|
      t.references :user_id, null: false, foreign_key: true
      t.references :project_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
