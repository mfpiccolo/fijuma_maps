class Search
  attr_reader :events, :latitude, :longitude, :api_key, :max, :date, :city, :within, :events, :title, :venue, :address, :city, :region, :postal_code, :category, :start_date, :end_date, :price
 
  def initialize(address)
    @address = ((address != nil && address != "") ? address : '95811') 
    @events = []
    meetup_search
  end

  def meetup_search
    post_response = Faraday.get do |request|
    coordinates = get_coords(@address)
    request.url "https://api.meetup.com/2/open_events?key=31326e6a4a3819374d109496c6f7aa&sign=true&lon=#{coordinates[:longitude]}&lat=#{coordinates[:latitude]}&page=20"
    end    
     
    meetups = JSON.parse(post_response.body)
    events = meetups['results'].each do |event|

      if event['name']  
        @name = event['name']
      end
      if event['group']
        @group_name = event['group']['name']
      end
      if event['time']
        @time = event['time']
      end
      if event['duration']
        @duration = event['duration']
      end
      if event['yes_rsvp_count']
        @attendees = event['yes_rsvp_count']
      end
      if event['event_url']
        @event_url = event['event_url']
      end
      if event['description']  
        @description = event['description']
      end
      if event['venue']
        @address = event['venue']['address_1']
        @city = event['venue']['city']
        @state = event['venue']['state']
        @zip_code = event['venue']['zip']
        @latitude = event['venue']['lat']
        @longitude = event['venue']['lon']
      end

      @events << Event.new(:name => @name, :group_name => @group_name, :time => @time, :duration => @duration, :attendees => @attendees, :event_url => @event_url, :description => @description, :address => @address, :city => @city, :state => @state, :zip_code => @zip_code, :latitude => @latitude, :longitude => @longitude)
    end
  end

  private

  def get_coords(address)
    gcoder = Gmaps4rails::Geocoder.new(address)
    coordinates = gcoder.get_coordinates.first
    {:longitude => coordinates[:lng], :latitude => coordinates[:lat]}
  end

end