class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.boolean :complete
      t.integer :creator_id  
      
      t.timestamps
    end

    add_foreign_key :projects, :users, column: :creator_id
  end
end
