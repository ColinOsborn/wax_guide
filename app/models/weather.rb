class Weather < OpenStruct

    def self.service
        @@service ||= WeatherService.new
    end

    def self.description(temp)

        case temp
        when -22..18
            "Toko Blue"
        when 19..28
             "Toko Red. If snow has fallen in the past 2-3 days and temps looking to dropping, consider mixing Toko Blue."
        when 29..100
            "Toko Yellow. The range for the yellow wax goes from 25F on up. If it's a hot day and been a while since it's snowed, Yellow is the way to go."
        else
            "Error, Please try me again"
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
