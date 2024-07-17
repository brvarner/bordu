class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.references :project_id, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.references :creator_id, null: false, foreign_key: true
      t.datetime :completed_at

      t.timestamps
    end
  end
end
