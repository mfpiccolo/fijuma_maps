class Event < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude, :gmaps, :name, :group_name, :time, :duration, :attendees, :event_url, :description, :city, :state, :zip_code, :venue
  acts_as_gmappable

  after_initialize :encode_description

  def gmaps4rails_address
    address
  end

  def slug
    name.downcase.gsub(" ", "_")
  end

  private

  def encode_description  
    @description = description.force_encoding "ASCII-8BIT" if description
    @name = name.force_encoding "ASCII-8BIT" if name
    @group_name = group_name.force_encoding "ASCII-8BIT" if group_name
    # @city = city.force_encoding "ASCII-8BIT"
    # @state = state.force_encoding "ASCII-8BIT"
    # @zip_code = zip_code.force_encoding "ASCII-8BIT"
  end
 
end