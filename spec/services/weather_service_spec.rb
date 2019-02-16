require 'rails_helper'

describe WeatherService do 
    context '#get_weather' do
        it 'returns current weather info' do 
            VCR.use_cassette("get_athlete") do
            current = WeatherService.new.get_current_conditions("332154")
            
            expect(current.first["WeatherText"]).to eq("Clear")
            expect(current.first["WeatherIcon"]).to eq(33)
            expect(current.first["HasPrecipitation"]).to eq(false)
            expect(current.first["PrecipitationType"]).to eq(nil)
            expect(current.first["IsDayTime"]).to eq(false)
            expect(current.first["Temperature"]["Metric"]["Value"]).to eq(-2.2)
            expect(current.first["Temperature"]["Metric"]["Unit"]).to eq("C")
            expect(current.first["Temperature"]["Metric"]["UnitType"]).to eq(17)
            expect(current.first["Temperature"]["Imperial"]["Value"]).to eq(28)
            expect(current.first["Temperature"]["Imperial"]["Unit"]).to eq("F")
            expect(current.first["Temperature"]["Imperial"]["UnitType"]).to eq(18)
            end
        end
    end
end
