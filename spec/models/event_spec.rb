require 'spec_helper' 

describe Event do 
  context '#slug' do 
    it 'turns an event name into a slug' do 
      event = Event.new(:name => 'Drinking Club')
      event.slug.should eq "drinking_club"
    end
  end
end