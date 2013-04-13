class SearchesController < ApplicationController


  def index
    @events = Search.new(params[:q]).events
    @json = @events.to_gmaps4rails do |event, marker|
      marker.infowindow render_to_string(:partial => "/events/infowindow", :locals => { :event => event})
      marker.title "#{event.address}"
      marker.json({:address => event.address})
      marker.picture({:picture => "https://dl.dropbox.com/u/20963921/map_icons/music_rock.png",
                    :width => 35,
                    :height => 35})
    end
  end
end