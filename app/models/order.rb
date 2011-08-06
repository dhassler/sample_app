class Order < ActiveRecord::Base
  attr_accessible :order_items, :name, :phone
  serialize :order_items
  validates :name, :presence => true
  validates :phone, :presence => true
end

