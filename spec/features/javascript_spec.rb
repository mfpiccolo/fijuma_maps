require 'spec_helper'

  feature "event map", :vcr do
    scenario "with results", :vcr do
      visit root_path
      sleep 3
      page.should have_content("180 Townsend St Tuesday Board Game Night")
    end
end