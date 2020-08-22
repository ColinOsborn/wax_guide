class HomeController < ApplicationController

    def index
    end

    def zipcode 
        @zip_query = params[:zipcode]
        # @output = Weather.service.get_postal_code_search(@zip_query)
        @output = Weather.service.get_autocomplete_search(@zip_query)
    end

    def location
        @location_query = params[:location].pop
        @output = Weather.service.get_current_conditions(@location_query)
    end

end