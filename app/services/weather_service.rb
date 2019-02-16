class WeatherService

    def initialize
        @connection = Faraday.new("http://dataservice.accuweather.com")
        @connection.headers["Authorization"] = "Bearer jDpKdDSRYBtPsaRttaYwGHjd34KtOgxx"
    end

    def get_current_conditions(location_id)
        response = @connection.get("/currentconditions/v1/#{location_id}?apikey=jDpKdDSRYBtPsaRttaYwGHjd34KtOgxx")
        parse(response)
    end

    def parse(response)
        JSON.parse(response.body)
    end

end