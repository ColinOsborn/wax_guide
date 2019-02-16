require 'rails_helper'

describe WeatherService do 
    context '#get_current_conditions' do
        it 'returns current weather info' do 
            VCR.use_cassette("get_current_conditions") do
            current = WeatherService.new.get_current_conditions("332154")
            
            expect(current.first["WeatherText"]).to eq("Clear")
            expect(current.first["WeatherIcon"]).to eq(33)
            expect(current.first["HasPrecipitation"]).to eq(false)
            expect(current.first["PrecipitationType"]).to eq(nil)
            expect(current.first["IsDayTime"]).to eq(false)
            expect(current.first["Temperature"]["Metric"]["Value"]).to eq(-2.8)
            expect(current.first["Temperature"]["Metric"]["Unit"]).to eq("C")
            expect(current.first["Temperature"]["Metric"]["UnitType"]).to eq(17)
            expect(current.first["Temperature"]["Imperial"]["Value"]).to eq(27.0)
            expect(current.first["Temperature"]["Imperial"]["Unit"]).to eq("F")
            expect(current.first["Temperature"]["Imperial"]["UnitType"]).to eq(18)
            end
        end
    end

    # context '#city_search' do
    #     it 'returns information for an array of cities that match the search text' do
    #         VCR.use_cassette("get_city_search", :record => :once) do
    #         search = WeatherService.new.get_city_search("Aspen")

    #         expect(search.first["Key"]).to eq(332154)
    #         expect(search.first["Type"]).to eq("City")
    #         expect(search.first["LocalizedName"]).to eq("Aspen")
    #         expect(search.first["EnglishName"]).to eq("Aspen")
    #         expect(search.first["PrimaryPostalCode"]).to eq(81611)
    #         end
    #     end
    # end

    context '#get_single_day_forecast' do
        it 'returns daily forecast data for a specific location' do 
            VCR.use_cassette("get_single_day_forecast") do
            forecast = WeatherService.new.get_single_day_forecast("332154")
            
            expect(forecast.first[1]["EffectiveDate"]).to eq("2019-02-16T01:00:00-07:00")
            expect(forecast.first[1]["Severity"]).to eq(3)
            expect(forecast.first[1]["Text"]).to eq("Snowfall from late Friday night into this afternoon will total 3-6 inches")
            expect(forecast.first[1]["Category"]).to eq("snow")
            expect(forecast.first[1]["EndDate"]).to eq("2019-02-16T19:00:00-07:00")
            expect(forecast.first[1]["EndDate"]).to eq("2019-02-16T19:00:00-07:00")
            end
        end
    end
    context '#get_single_hourly_forecast' do
        it 'returns forecast data for the next hour for a specific location' do 
            VCR.use_cassette("get_single_hourly_forecast") do
            forecast = WeatherService.new.get_single_hourly_forecast("332154")

            expect(forecast.first["DateTime"]).to eq("2019-02-16T00:00:00-07:00")
            expect(forecast.first["EpochDateTime"]).to eq(1550300400)
            expect(forecast.first["WeatherIcon"]).to eq(34)
            expect(forecast.first["IconPhrase"]).to eq("Mostly clear")
            expect(forecast.first["IsDaylight"]).to eq(false)
            expect(forecast.first["Temperature"]["Value"]).to eq(27.0)
            expect(forecast.first["Temperature"]["Unit"]).to eq("F")
            expect(forecast.first["Temperature"]["UnitType"]).to eq(18)
            expect(forecast.first["PrecipitationProbability"]).to eq(11)
            end
        end
    end
end