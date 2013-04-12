require 'spec_helper' 

describe Event do 
  context 'accessibility' do 
    it {should allow_mass_assignment_of :address}
    it {should allow_mass_assignment_of :latitude}
    it {should allow_mass_assignment_of :longitude}
    it {should allow_mass_assignment_of :gmaps}
  end

  context '#gmaps4rails_address' do
    it 'returns the address' do
      event = Event.new(:address => '1234 Whever Dr., Fair Oaks, CA 95628')
      event.gmaps4rails_address.should eq '1234 Whever Dr., Fair Oaks, CA 95628'
    end
  end
end