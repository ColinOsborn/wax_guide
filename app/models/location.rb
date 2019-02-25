class Location < OpenStruct

    def self.service
        @@service ||= WeatherService.new
    end

    def self.find(zipcode)
        byebug
        location_hash = service.get_postal_code_search(zipcode)
        Location.new(location_hash)
    end

    # def self.find(user_id)
    #     athlete_hash = service.get_athlete(user_id)
    #     Athlete.new(athlete_hash)
    # end

end