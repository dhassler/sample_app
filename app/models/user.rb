class User < ActiveRecord::Base
  attr_accessible :email, :restaurant_id, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :on => :create
  validates_uniqueness_of :email, :on => :create
  belongs_to :restaurant
end
