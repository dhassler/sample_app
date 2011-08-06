require 'spec_helper'

describe Order do
  
  it "should accept a hash of item to quantity mappings" do
    order_items = { 50 => 1, 51 => 2, 53 => 3}
    order = Order.new(:order_items => order_items)
    order.order_items.size.should == 3
    order.order_items.keys.first.should == 50
    order.order_items[50].should == 1
  end
end
