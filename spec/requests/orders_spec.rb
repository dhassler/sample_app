require 'spec_helper'

describe "Orders" do
  
  describe "GET /orders" do 
    before(:each) do
      name = "Panzano"
      zip  = "80123"
      @restaurant = Restaurant.create!(:name => name, :zip => zip)
      
      apps = @restaurant.menu_sections.create!(:name => "Appetizers")
      apps.menu_items.create!(:name => "Nachos", :price => 4.99)
      
      entrees = @restaurant.menu_sections.create!(:name => "Entrees")
      entrees.menu_items.create!(:name => "Lasagna", :price => 9.99)
      
      desserts = @restaurant.menu_sections.create!(:name => "Desserts")
      desserts.menu_items.create!(:name => "Chocolate Explosion", :price => 3.99)
    end
    
    it "should place an order successfully" do
      visit restaurant_path(@restaurant)
      response.should have_selector("h2", :content => @restaurant.name)
      @restaurant.menu_sections.each do |ms|
        ms.menu_items.each do |mi|
          response.should have_selector("input", :id => "order_items_" + mi.id.to_s)
          fill_in "order_items_" + mi.id.to_s, :with => "1"
        end
      end
      click_button
      response.should render_template('orders/delivery')
      response.should have_selector("input", :id => "order_name")
      response.should have_selector("input", :id => "order_phone")
      @restaurant.menu_sections.each do |ms|
        ms.menu_items.each do |mi|
          response.should contain(mi.name)
        end
      end 
      fill_in "Name",  :with => "Joe Jones"
      fill_in "Phone", :with => "123-123-1234"
      click_button
    end
  end
end
