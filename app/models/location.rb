class Location
    attr_reader :service

    def self.service
        @@service ||= WeatherService.new
    end

    def self.find(zipcode)
        service.get_postal_code_search(zipcode)
    end
 
end