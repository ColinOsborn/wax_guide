class Location < OpenStruct
    attr_reader :service

    def self.service
        @service ||= WeatherService.new
    end

    def self.find(zipcode)
        location_hash = service.get_postal_code_search(zipcode)
        Location.new(location_hash)
    end

end