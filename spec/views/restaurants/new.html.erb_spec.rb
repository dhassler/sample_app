require 'spec_helper'

describe "restaurants/new.html.erb" do
  before(:each) do
    assign(:restaurant, stub_model(Restaurant,
      :name => "MyString",
      :latitude => 1.5,
      :longitude => 1.5
    ).as_new_record)
  end

  it "renders new restaurant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => restaurants_path, :method => "post" do
      assert_select "input#restaurant_name", :name => "restaurant[name]"
      assert_select "input#restaurant_latitude", :name => "restaurant[latitude]"
      assert_select "input#restaurant_longitude", :name => "restaurant[longitude]"
    end
  end
end
