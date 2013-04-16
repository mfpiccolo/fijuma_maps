class Search
  attr_reader :events, :latitude, :longitude, :api_key, :max, :date, :city, :within, :events, :title, :venue, :address, :city, :region, :postal_code, :category, :start_date, :end_date, :price, :start_time, :end_time
 
  def initialize(params)
    if params["/searches"]
      @address = params["/searches"][:search_location]
      @start_time = (Time.local(params['/searches']["start_time(1i)"], params['/searches']["start_time(2i)"], params['/searches']["start_time(3i)"]).to_i) * 1000
      @end_time = (Time.local(params['/searches']["end_time(1i)"], params['/searches']["end_time(2i)"], params['/searches']["end_time(3i)"]).to_i) * 1000
    else
      @address = '94117'
      @start_time = (DateTime.now.to_i) * 1000
      @end_time = ((DateTime.now + 24.hours).to_i) * 1000
    end
    @events = []
    meetup_search
  end

  def meetup_search
    post_response = Faraday.get do |request|
      coordinates = get_coords(@address)
      request.url "https://api.meetup.com/2/open_events?key=31326e6a4a3819374d109496c6f7aa&sign=true&lon=#{coordinates[:longitude]}&lat=#{coordinates[:latitude]}&time=#{@start_time},#{@end_time}&page=20"
    end   
    meetups = JSON.parse(post_response.body)
    events = meetups['results'].each do |event|

      name = event['name']
      group_name = event['group']['name']
      time = event['time']
      duration = event['duration']
      attendees = event['yes_rsvp_count']
      event_url = event['event_url'] 
      description = event['description']
      if event['venue']
        address = event['venue']['address_1']
        city = event['venue']['city']
        state = event['venue']['state']
        zip_code = event['venue']['zip']
        latitude = event['venue']['lat']
        longitude = event['venue']['lon']
      end

      @events << Event.new(:name => name, :group_name => group_name, :time => time, :duration => duration, :attendees => attendees, :event_url => event_url, :description => description, :address => address, :city => city, :state => state, :zip_code => zip_code, :latitude => latitude, :longitude => longitude)
    end
  end

  private

  def get_coords(address)
    gcoder = Gmaps4rails::Geocoder.new(address)
    coordinates = gcoder.get_coordinates.first
    {:longitude => coordinates[:lng], :latitude => coordinates[:lat]}
  end

end