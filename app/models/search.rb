class Search
  attr_reader :events, :latitude, :longitude, :api_key, :max, :date, :city, :within, :events, :title, :venue, :address, :city, :region, :postal_code, :category, :start_date, :end_date, :price
 
  def initialize(address)
    meetup_search
  end

  def meetup_search
    #Faraday search
    @events = Event.new(:latitude => @latitude)
  end
end