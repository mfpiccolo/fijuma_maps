class Event < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude, :gmaps, :name, :group_name, :time, :duration, :attendees, :event_url, :description, :city, :state, :zip_code, :venue
  acts_as_gmappable

  after_initialize :encode_description

  def gmaps4rails_address
    address
  end


  private

  def encode_description
    @description = description.force_encoding "ASCII-8BIT"
    @name = name.force_encoding "ASCII-8BIT"
    @group_name = group_name.force_encoding "ASCII-8BIT"
  end
 
end