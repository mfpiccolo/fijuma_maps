class Event < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude, :gmaps
  acts_as_gmappable
 
  def gmaps4rails_address
    address
  end

end