class WeatherService

    def initialize
        @connection = Faraday.new("http://dataservice.accuweather.com")
        @api_key = Rails.application.credentials.api_key
        @connection.headers["Authorization"] = "Bearer #{@api_key}"
    end

    def get_current_conditions(location_id)
        response = @connection.get("/currentconditions/v1/#{location_id}?apikey=#{@api_key}")
        parse(response)
    end

    def get_postal_code_search(zip_query)
        response = @connection.get("/locations/v1/postalcodes/search?apikey=#{@api_key}=#{zip_query}")
        parse(response)
    end

    def get_single_day_forecast(location_id)
        response = @connection.get("/forecasts/v1/daily/1day/#{location_id}?apikey=#{@api_key}")
        parse(response)
    end     

    def get_single_hourly_forecast(location_id)
        response = @connection.get("/forecasts/v1/hourly/1hour/#{location_id}?apikey=#{@api_key}")
        parse(response)
    end     

    def parse(response)
        JSON.parse(response.body)
    end

end