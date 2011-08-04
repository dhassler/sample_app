class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :name
      t.float :price
      t.integer :menu_section_id

      t.timestamps
    end
  end
end
