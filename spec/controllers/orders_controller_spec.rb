require 'spec_helper'

describe OrdersController do

  describe "GET 'new'" do
    
    before(:each) do
      @restaurant = Restaurant.create!(:name => "Brooks", :zip => "80112")
      apps = @restaurant.menu_sections.create!(:name => "Appetizers")
      apps.menu_items.create!(:name => "Nachos", :price => 4.99)
      entrees = @restaurant.menu_sections.create!(:name => "Entrees")
      entrees.menu_items.create!(:name => "Lasagna", :price => 9.99)
      desserts = @restaurant.menu_sections.create!(:name => "Desserts")
      desserts.menu_items.create!(:name => "Chocolate Explosion", :price => 3.99)
    end
    
    it "should be successful" do
      order_items = Hash.new  
      MenuItem.all.each do |item|
        order_items[item.id.to_s] = "1"
      end
      
      post :new, :order_items => order_items
      response.should be_success
    end
  end

end
