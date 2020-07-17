class HomeController < ApplicationController
    require 'net/http'

    def index

    end

    def zipcode 
        @zip_query = params[:zipcode]
        api_key = Rails.application.credentials.api_key
        @output = Weather.service.get_postal_code_search(@zip_query)
    end

    def location
        @location_query = params[:location]
        api_key = Rails.application.credentials.api_key
        key = "jDpKdDSRYBtPsaRttaYwGHjd34KtOgxx"
        @url = "http://dataservice.accuweather.com/currentconditions/v1/#{@location_query}?apikey=#{key}"
        @uri = URI(@url)
        @response = Net::HTTP.get(@uri)
        @output = JSON.parse(@response)

        temp = @output.first["Temperature"]["Imperial"]["Value"]
        case temp
        when -22..18
            @toko_color = "blue"
            @toko_description = "Toko Blue"
        when 19..28
            @toko_color = "red"
            @toko_description = "Toko Red. If snow has fallen in the past 2-3 days and temps looking to dropping, consider mixing Toko Blue."
        when 29..100
            @toko_color = "yellow"
            @toko_description = "Toko Yellow. The range for the yellow wax goes from 25F on up. If it's a hot day and been a while since it's snowed, Yellow is the way to go."
        else
            @toko_description = "Error, Please try me again"
        end
    end

        # All of this logic needs to be more or less moved to the Weather Service
end