require 'spec_helper'

feature "event map" do
  scenario "with results", :js => true do
    visit searches_path
    find('2641 Cottage Way, Suite 7 ').click

    page.should have_content("whatever: -121.504883")
  end


end