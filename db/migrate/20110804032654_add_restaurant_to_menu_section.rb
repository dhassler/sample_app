class AddRestaurantToMenuSection < ActiveRecord::Migration
  def change
    add_column :menu_sections, :restaurant_id, :integer
  end
end
