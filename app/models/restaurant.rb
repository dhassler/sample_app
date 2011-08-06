class Restaurant < ActiveRecord::Base
  validates :name, :presence => true
  validates :zip,  :presence => true 
  
  has_many :menu_sections
  has_many :users
  
  geocoded_by :zip
  after_validation :geocode
  
  default_scope order 'name'
end
