require 'spec_helper'

describe Restaurant do
 
 it "attribute validation" do
   restaurant = Restaurant.new(:name => "", :zip => "12345")
   restaurant.should_not be_valid
 end
 
 it "should require a zip code" do
   restaurant = Restaurant.new(:name => "Spago", :zip => "")
   restaurant.should_not be_valid
  end
  
  describe "geolocation" do
    it "should have lat/long after saving" do
      restaurant = Restaurant.create!(:name => "The Med", :zip => "80303")
      restaurant.latitude.should_not be(nil)
      restaurant.longitude.should_not be(nil)
    end
  end
  
  describe "proximity searching" do
    it "should return results sorted by distance" do
       rest1 = Restaurant.create!({ :name => 'Spago Hawaii', :zip => "96753"})
       rest2 = Restaurant.create!({ :name => 'Boulder Cafe', :zip => "80303"})
       rest3 = Restaurant.create!({ :name => 'Denver Cafe', :zip => "80111"})
       
       Restaurant.near("80301", 10).first.should == rest2
     end
   end   
end
