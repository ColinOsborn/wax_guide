require 'rails_helper'

RSpec.feature 'user lands on homepage and enters zipcode' do
    scenario "user enters zipcode to return location for wax advice" do

        visit '/locations'

        expect(page).to have_content("Wax Guide")

        fill_in :search, with: "81611"
        click_on "Search"

        expect(current_path).to eq(location_path)
        # expect(response).to have_http_status(:success)
        expect(page).to have_content("Aspen, CO")
        expect(page).to have_content("")
        expect(page).to have_content("Lat 39.172")
        expect(page).to have_content("Long -106.725")

        expect(page).to have_content("-2.8 Celsius")
        expect(page).to have_content("27.0 F")
    end
end
