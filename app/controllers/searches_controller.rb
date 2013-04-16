class SearchesController < ApplicationController
  include ApplicationHelper


  def index
    if params['/searches']
      @location = params['/searches'][:search_location]
      @start_time = Time.local(params['/searches']["start_time(1i)"], params['/searches']["start_time(2i)"], params['/searches']["start_time(3i)"])
      @end_time = Time.local(params['/searches']["end_time(1i)"], params['/searches']["end_time(2i)"], params['/searches']["end_time(3i)"])
    end
    @events = Search.new(params).events
    @json = @events.to_gmaps4rails do |event, marker|
      if event == @events.last
        marker.infowindow render_to_string(:partial => "/searches/infowindow_address", :locals => { :event => event})
        marker.picture({:picture => "https://dl.dropboxusercontent.com/u/20963921/map_icons/soil-boring-icon.png",
                      :width => 35,
                      :height => 35})
      else
        marker.infowindow render_to_string(:partial => "/searches/infowindow", :locals => { :event => event})
        marker.title "#{event.name}"
        marker.picture({:picture => "https://dl.dropbox.com/u/20963921/map_icons/music_rock.png",
                    :width => 35,
                    :height => 35})
      end
    end
    @user_location = 
    @json.force_encoding "ASCII-8BIT"
  end
end