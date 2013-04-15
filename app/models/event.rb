class Event < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude, :gmaps, :name, :group_name, :time, :duration, :attendees, :event_url, :description, :city, :state, :zip_code, :venue
  acts_as_gmappable

  after_initialize :parse_description

  def gmaps4rails_address
    address
  end


  private

  def parse_description
    if String.method_defined?(:encode)
      @description = description.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
      @description = description.encode!('UTF-8', 'UTF-16')
    else
      ic = Iconv.new('UTF-8', 'UTF-8//IGNORE')
      @description = ic.iconv(description)
      gsdg
    end
    @description = @description.gsub(/<h\d>[^>]*>/,'').gsub(/<img[^>]*>/,'').gsub(/<\/?[^>]*>/, '').gsub(/(?<!\n)\n(?!\n)/, '')
  end

end