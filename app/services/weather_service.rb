class WeatherService

    def initialize
        @connection = Faraday.new("http://dataservice.accuweather.com")
        @connection.headers["Authorization"] = "Bearer jDpKdDSRYBtPsaRttaYwGHjd34KtOgxx"
    end

    def get_current_conditions(location_id)
        response = @connection.get("/currentconditions/v1/#{location_id}?apikey=jDpKdDSRYBtPsaRttaYwGHjd34KtOgxx")
        parse(response)
    end

    def get_postal_code_search(zip)
        response = @connection.get("/locations/v1/postalcodes/search?apikey=jDpKdDSRYBtPsaRttaYwGHjd34KtOgxx&q=#{zip}")
        parse(response)
    end

    def get_single_day_forecast(location_id)
        response = @connection.get("/forecasts/v1/daily/1day/#{location_id}?apikey=jDpKdDSRYBtPsaRttaYwGHjd34KtOgxx")
        parse(response)
    end     

    def get_single_hourly_forecast(location_id)
        response = @connection.get("/forecasts/v1/hourly/1hour/#{location_id}?apikey=jDpKdDSRYBtPsaRttaYwGHjd34KtOgxx")
        parse(response)
    end     

    def parse(response)
        JSON.parse(response.body)
    end

end