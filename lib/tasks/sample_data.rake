require 'faker'

namespace :db do
  desc "Fill database with fake restaurants"
  task :populate => :environment do
    10.times do |n|
      name = Faker::Company.name
      zip  = Faker::Address.zip_code
      restaurant = Restaurant.create!(:name => name, :zip => zip)
      
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
      
      user = User.create!(:email => "rest" + restaurant.id.to_s, :password => "password", 
                      :password_confirmation => "password", :restaurant_id => restaurant.id)
    end 
    
    user = User.new(:email => "admin", :password => "admin", :password_confirmation => "admin")
    user.admin = true
    user.save
  end
end