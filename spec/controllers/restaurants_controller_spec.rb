require 'spec_helper'

describe RestaurantsController do
  render_views

  # This should return the minimal set of attributes required to create a valid
  # Restaurant. As you add validations to Restaurant, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {:name => "Joe's", :zip => "12345"}
  end

  describe "GET index" do
    it "assigns all restaurants as @restaurants" do
      restaurant = Restaurant.create! valid_attributes
      get :index
      assigns(:restaurants).should eq([restaurant])
    end
  end

  describe "GET show" do
    it "assigns the requested restaurant as @restaurant" do
      restaurant = Restaurant.create! valid_attributes
      get :show, :id => restaurant.id.to_s
      assigns(:restaurant).should eq(restaurant)
    end
    
    it "should show the menu" do
      restaurant = create_restaurant()
      get :show, :id => restaurant
      response.should have_selector("div.menusection", :content => restaurant.menu_sections[0].name)
      response.should have_selector("div.menusection", :content => restaurant.menu_sections[1].name)
      response.should have_selector("div.menusection", :content => restaurant.menu_sections[2].name)
    end    
  end
end


private

def create_restaurant
  restaurant = Restaurant.create!(:name => "Bennigans", :zip => "80302")
  
  apps = restaurant.menu_sections.create!(:name => "Appetizers")
  apps.menu_items.create!(:name => "Nachos", :price => 4.99)
  apps.menu_items.create!(:name => "Chicken Fingers", :price => 5.99)
  
  entrees = restaurant.menu_sections.create!(:name => "Entrees")
  entrees.menu_items.create!(:name => "Lasagna", :price => 9.99)
  entrees.menu_items.create!(:name => "Pork Ribs", :price => 14.99)
  entrees.menu_items.create!(:name => "Club Sandwich", :price => 5.99)
  
  desserts = restaurant.menu_sections.create!(:name => "Desserts")
  desserts.menu_items.create!(:name => "Chocolate Explosion", :price => 3.99)
  desserts.menu_items.create!(:name => "Carrot Cake", :price => 2.99)
  return restaurant
end
