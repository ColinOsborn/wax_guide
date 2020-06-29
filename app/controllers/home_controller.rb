class HomeController < ApplicationController

    def index

    end

    def zipcode 
        @zip_query = params[:zipcode]
        api_key = Rails.application.credentials.api_key
        @url = "http://dataservice.accuweather.com/locations/v1/postalcodes/search?apikey=#{api_key}&q=#{@zip_query}"
        @uri = URI(@url)
        @response = Net::HTTP.get(@uri)
        @output = JSON.parse(@response)
    end

    def location
        @location_query = params[:location]
        api_key = Rails.application.credentials.api_key
        @url = "http://dataservice.accuweather.com/currentconditions/v1/#{@location_query}?apikey=#{api_key}"
        @uri = URI(@url)
        @response = Net::HTTP.get(@uri)
        @output = JSON.parse(@response)
    end

        # All of this logic needs to be more or less moved to the Weather Service
end