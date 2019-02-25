class Location
    attr_reader :service

    def self.service
        @@service ||= WeatherService.new
    end

    # def self.find(zipcode)
    #     location_hash = service.get_postal_code_search(zipcode)
    #     Location.new(location_hash)
    # end

    def self.find(zipcode)
        service.get_postal_code_search(zipcode)
    end

end