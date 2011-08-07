class Order < ActiveRecord::Base
  attr_accessible :order_items, :name, :phone, :restaurant_id
  serialize :order_items
  validates :name, :presence => true
  validates :phone, :presence => true
  belongs_to :restaurant
  
  default_scope order("created_at DESC")
end

