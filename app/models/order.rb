class Order < ActiveRecord::Base
  serialize :order_items
  validates :name, :presence => true
  validates :phone, :presence => true
  
end

