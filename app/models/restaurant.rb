class Restaurant < ActiveRecord::Base
  validates :name, :presence => true
  validates :zip,  :presence => true 
  
  has_many :menu_sections
  
  geocoded_by :zip
  after_validation :geocode                                 
end
