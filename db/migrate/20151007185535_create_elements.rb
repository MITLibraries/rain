class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.belongs_to :workflow, index: true
      t.belongs_to :element_type, index: true
      t.string :label
      t.string :help
      t.string :error
      t.integer :parent_id
      t.boolean :required, default: false
      t.integer :position
      t.timestamps null: false
    end
  end
end
