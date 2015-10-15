class CreateElementTypeAccepts < ActiveRecord::Migration
  def change
    create_table :element_type_accepts do |t|
      t.belongs_to :element_type
      t.integer :accepts_element_type_id
      t.timestamps null: false
    end
  end
end
