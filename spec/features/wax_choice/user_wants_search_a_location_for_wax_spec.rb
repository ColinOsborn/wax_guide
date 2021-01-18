require 'rails_helper'

RSpec.feature 'User wants to search a location for wax recommendation' do
  scenario "they enter location data to find their ski location" do
    location = "Aspen"

    visit home_path
    fill_in "Location", with: location
    click_on "Search"

  end
end