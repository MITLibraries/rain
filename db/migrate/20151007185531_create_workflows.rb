class CreateWorkflows < ActiveRecord::Migration
  def change
    create_table :workflows do |t|
      t.string :name, null: false
      t.timestamps null: false
    end
  end
end
