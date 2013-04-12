class Event < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude, :gmaps, :name, :group_name, :time, :duration, :attendees, :event_url, :description, :city, :state, :zip_code
  acts_as_gmappable

  def gmaps4rails_address
    address
  end

end