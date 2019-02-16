require 'rails_helper'

RSpec.feature 'user lands on homepage and enters zipcode' do
    scenario "user lands on homepage and enters zipcode" do

        visit root_path

        expect(page).to have_content("Zipcode")
        click_on "Search"

    end
end
