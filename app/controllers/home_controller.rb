class HomeController < ApplicationController

    def index

    end

    def zipcode 
        @zip_query = params[:zipcode]
        api_key = Rails.application.credentials.api_key
        @output = Weather.service.get_postal_code_search(@zip_query)
    end

    def location
        @location_query = params[:location]
        @output = Weather.service.get_current_conditions(@location_query)
    end

end