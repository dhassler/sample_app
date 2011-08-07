class Restaurant < ActiveRecord::Base
  validates :name, :presence => true
  validates :zip,  :presence => true 
  
  has_many :menu_sections
  has_many :users
  
  geocoded_by :zip
  after_validation :geocode
  
  default_scope order 'name'
  
  def has_menu_section?(section_name)
    self.menu_sections.select{ |s| s.name == section_name }.size > 0
  end
end
