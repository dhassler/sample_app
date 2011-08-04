class CreateMenuSections < ActiveRecord::Migration
  def change
    create_table :menu_sections do |t|
      t.string :name
      t.integer :order

      t.timestamps
    end
  end
end
