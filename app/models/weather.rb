class Weather < OpenStruct

    def self.service
        @@service ||= WeatherService.new
    end

    def self.description(temperature, conditions)
        temp = toko_temp_range(temperature)
        condition = conditions_parse(conditions)

        if "Blue" && "Sunny"
            "Toko Blue"
        elsif "Blue/Red" && "Snow"
            "Toko Blue. When snow is present, it's extra cold and coarse."
        elsif "Blue/Red" && "Sunny"
            "Toko Red. If things stay sunny. Red only, if temps start dropping, consider mixing some Toko Blue 50-50"
        elsif "Red" && "Sunny"
            "Toko Red"
        elsif "Red" && "Snow"
            "Toko Red"
        elsif "Yellow" && "Sunny"
            "Toko Yellow"
        elsif "Red/Yellow" && "Snow"
            "Toko Yellow. If temps start dropping or cold snow, mix with Toko Red"
        elsif nil || nil
            "An Error occured"
        end
    end

    def self.toko_temp_range(temp)
        case temp
        when -22..10
            "Blue"
        when 11..18
            "Blue/Red"
        when 19..24
             "Red"
        when 25..29
            "Red/Yellow"
        when 29..100
            "Yellow"
        else
            "Error, Please try me again"
        end
    end

    def self.conditions_parse(conditions)
        clean = conditions.downcase
        if clean.include?("snow") == true
            "Snow"
        elsif clean.include?("clear") == true
            "Clear"
        elsif clean.include?("rain") == true
            "Rain"
        elsif clean.include?("sunny") == true
            "Sunny"
        else
            "No Data"
        end
    end

    def self.color(temp)
        case temp
        when -22..18
            "blue"
        when 19..28
            "red"
        when 29..100
            "yellow"
        else
            " "
        end
    end

    def self.swix_description(temp)
        case temp
        when -25..10
            "CH4 Green"
        when 11..15
            "CH5 Turquoise"
        when 15..23
            "CH6 Blue"
        when 24..31
            "CH7 Violet"
        when 32..50
            "CH10 Yellow"
        else
            "please refresh data"
        end
    end

    def self.swix_color(temp)
           case temp
        when -25..10
            "green"
        when 11..15
            "turquoise"
        when 15..23
            "blue"
        when 24..31
            "violet" 
        when 32..50
            "yellow"
        else
            "please refresh data"
        end
    end

    def self.weather_text(condition)
        # this will grab weather icon number and then render the correct SCSS class  
    end


end
