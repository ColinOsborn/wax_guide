class Weather < OpenStruct

    def self.service
        @@service ||= WeatherService.new
    end

    def self.temp(temp)

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


end
