require 'rails_helper'
require 'ostruct'

RSpec.describe Weather, type: :model do
  context 'handles unauthorized api response or data with errors ' do
    it 'detects an unauthorized call' do
      error = OpenStruct.new(Code: 'Unauthorized')

      handled = Weather.error_handling(error)
      expect(handled).to eq(true)
    end
  end
  context 'cleaning the api data so it no longer parses in the frontend' do
    it 'parses the api dump to remove logic from views' do
      data = [{"LocalObservationDateTime"=>"2021-01-08T22:10:00-07:00",
             "EpochTime"=>1610169000, "WeatherText"=>"Partly cloudy",
             "WeatherIcon"=>35, "HasPrecipitation"=>false,
             "PrecipitationType"=>nil, "IsDayTime"=>false,
             "Temperature"=>{"Metric"=>{"Value"=>-7.2, "Unit"=>"C", "UnitType"=>17},
             "Imperial"=>{"Value"=>19.0, "Unit"=>"F", "UnitType"=>18}},
             "MobileLink"=>"http://m.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us",
             "Link"=>"http://www.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us"}]

      better = {"LocalObservationDateTime"=>"2021-01-08T22:10:00-07:00", "EpochTime"=>1610169000, 
              "WeatherText"=>"Partly cloudy", "WeatherIcon"=>35, "HasPrecipitation"=>false, 
              "PrecipitationType"=>nil, "IsDayTime"=>false, 
              "Temperature"=>{"Metric"=>{"Value"=>-7.2, "Unit"=>"C", "UnitType"=>17}, 
              "Imperial"=>{"Value"=>19.0, "Unit"=>"F", "UnitType"=>18}}, 
              "MobileLink"=>"http://m.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us", 
              "Link"=>"http://www.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us"}

      clean = Weather.output_parse(data)
      expect(clean).to eq(better)
    end

    it 'cleans the metric temperature data' do
      data = [{"LocalObservationDateTime"=>"2021-01-08T22:10:00-07:00",
             "EpochTime"=>1610169000, "WeatherText"=>"Partly cloudy",
             "WeatherIcon"=>35, "HasPrecipitation"=>false,
             "PrecipitationType"=>nil, "IsDayTime"=>false,
             "Temperature"=>{"Metric"=>{"Value"=>-7.2, "Unit"=>"C", "UnitType"=>17},
             "Imperial"=>{"Value"=>19.0, "Unit"=>"F", "UnitType"=>18}},
             "MobileLink"=>"http://m.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us",
             "Link"=>"http://www.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us"}]

      celsius = Weather.metric(data)
      expect(celsius).to eq(-7.2)
    end

    xit 'returns an error instead of breaking' do
      data = [{"Temperature"=>{"Metric"=>{"Value"=>nil, "Unit"=>"C", "UnitType"=>17}}}]

      error = Weather.metric(data)
      expect(error).to eq("Error")
    end

    xit 'cleans the imperial temperature data' do
      data = [{"Temperature"=>{"Metric"=>{"Value"=>-7.2, "Unit"=>"C", "UnitType"=>17}, 
              "Imperial"=>{"Value"=>19.0, "Unit"=>"F", "UnitType"=>18}}}]

      farenheit = Weather.imperial(data)
      expect(farenheit).to eq(19)
    end

    xit 'returns and error instead of breaking' do
      data = [{"Temperature"=>{"Metric"=>{"Value"=>-7.2, "Unit"=>"C", "UnitType"=>17}, 
              "Imperial"=>{"Value"=>nil, "Unit"=>"F", "UnitType"=>18}}}]

      error = Weather.imperial(data)
      expect(error).to eq("Error")
    end
  end

  # it 'provides correct wax (toko) description' do
  #   blue = [{"EpochTime"=>1610169000, "WeatherText"=>"Sunny",
  #            "WeatherIcon"=>35, "HasPrecipitation"=>false,
  #            "PrecipitationType"=>nil, "IsDayTime"=>false,
  #            "Temperature"=>{"Metric"=>{"Value"=>-7.2, "Unit"=>"C", "UnitType"=>17},
  #            "Imperial"=>{"Value"=>12, "Unit"=>"F", "UnitType"=>18}},
  #          }]
  #   not_red_blue = [{"EpochTime"=>1610169000, "WeatherText"=>"Snow",
  #            "WeatherIcon"=>35, "HasPrecipitation"=>false,
  #            "PrecipitationType"=>nil, "IsDayTime"=>false,
  #            "Temperature"=>{"Metric"=>{"Value"=>-7.2, "Unit"=>"C", "UnitType"=>17},
  #            "Imperial"=>{"Value"=>17, "Unit"=>"F", "UnitType"=>18}},
  #          }]

  #   true_blue = Weather.description(blue, blue)
  #   # not_red_blue = Weather.description(not_red_blue, not_red_blue)
  #   # warm = Weather.description(yellow)

  #   expect(true_blue).to eq("Toko Blue")
  #   # expect(not_red_blue).to eq("Toko Blue. When new snow is present, it's extra cold and coarse.")
  #   # expect(warm).to eq("Toko Yellow. The range for the yellow wax goes from 25F on up. If it's a hot day and been a while since it's snowed, Yellow is the way to go.")
  # end

  # it 'provides correct wax (toko) color' do
  #   blue = [{"EpochTime"=>1610169000, "WeatherText"=>"Sunny",
  #            "WeatherIcon"=>35, "HasPrecipitation"=>false,
  #            "PrecipitationType"=>nil, "IsDayTime"=>false,
  #            "Temperature"=>{"Metric"=>{"Value"=>-7.2, "Unit"=>"C", "UnitType"=>17},
  #            "Imperial"=>{"Value"=>12, "Unit"=>"F", "UnitType"=>18}},
  #           }]
  #   red = [{"EpochTime"=>1610169000, "WeatherText"=>"Sunny",
  #            "WeatherIcon"=>35, "HasPrecipitation"=>false,
  #            "PrecipitationType"=>nil, "IsDayTime"=>false,
  #            "Temperature"=>{"Metric"=>{"Value"=>-7.2, "Unit"=>"C", "UnitType"=>17},
  #            "Imperial"=>{"Value"=>22, "Unit"=>"F", "UnitType"=>18}},
  #           }]
  #   yellow = [{"EpochTime"=>1610169000, "WeatherText"=>"Sunny",
  #            "WeatherIcon"=>35, "HasPrecipitation"=>false,
  #            "PrecipitationType"=>nil, "IsDayTime"=>false,
  #            "Temperature"=>{"Metric"=>{"Value"=>-7.2, "Unit"=>"C", "UnitType"=>17},
  #            "Imperial"=>{"Value"=>32, "Unit"=>"F", "UnitType"=>18}},
  #           }]

  #   cold = Weather.color(blue)
  #   med = Weather.color(red)
  #   warm = Weather.color(yellow)

  #   expect(cold).to eq("blue")
  #   expect(med).to eq("red")
  #   expect(warm).to eq("yellow")
  # end

  # it "provides correct swix wax description" do
  #   green = 0
  #   turquoise = 12
  #   blue = 17
  #   violet = 27
  #   yellow = 40

  #   frigid = Weather.swix_description(green)
  #   frozen = Weather.swix_description(turquoise)
  #   cold = Weather.swix_description(blue)
  #   slight_cold = Weather.swix_description(violet)
  #   warm = Weather.swix_description(yellow)

  #   expect(frigid).to eq("CH4 Green")
  #   expect(frozen).to eq("CH5 Turquoise")
  #   expect(cold).to eq("CH6 Blue")
  #   expect(slight_cold).to eq("CH7 Violet")
  #   expect(warm).to eq("CH10 Yellow")
  # end

  # it "parses weather text and conditions" do
  #   most = [{"LocalObservationDateTime"=>"2021-01-08T22:10:00-07:00",
  #            "EpochTime"=>1610169000, "WeatherText"=>"Mostly Clear",
  #            "WeatherIcon"=>35, "HasPrecipitation"=>false,
  #            "PrecipitationType"=>nil, "IsDayTime"=>false,
  #            "Temperature"=>{"Metric"=>{"Value"=>-7.2, "Unit"=>"C", "UnitType"=>17},
  #            "Imperial"=>{"Value"=>19.0, "Unit"=>"F", "UnitType"=>18}},
  #            "MobileLink"=>"http://m.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us",
  #            "Link"=>"http://www.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us"}]
  #   some_snow = [{"LocalObservationDateTime"=>"2021-01-08T22:10:00-07:00",
  #            "EpochTime"=>1610169000, "WeatherText"=>"Mostly Cloudy w/ Snow",
  #            "WeatherIcon"=>35, "HasPrecipitation"=>false,
  #            "PrecipitationType"=>nil, "IsDayTime"=>false,
  #            "Temperature"=>{"Metric"=>{"Value"=>-7.2, "Unit"=>"C", "UnitType"=>17},
  #            "Imperial"=>{"Value"=>19.0, "Unit"=>"F", "UnitType"=>18}},
  #            "MobileLink"=>"http://m.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us",
  #            "Link"=>"http://www.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us"}]
  #   some_sun = [{"LocalObservationDateTime"=>"2021-01-08T22:10:00-07:00",
  #            "EpochTime"=>1610169000, "WeatherText"=>"Partly Sunny",
  #            "WeatherIcon"=>35, "HasPrecipitation"=>false,
  #            "PrecipitationType"=>nil, "IsDayTime"=>false,
  #            "Temperature"=>{"Metric"=>{"Value"=>-7.2, "Unit"=>"C", "UnitType"=>17},
  #            "Imperial"=>{"Value"=>19.0, "Unit"=>"F", "UnitType"=>18}},
  #            "MobileLink"=>"http://m.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us",
  #            "Link"=>"http://www.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us"}]
  #   int_clouds = [{"LocalObservationDateTime"=>"2021-01-08T22:10:00-07:00",
  #            "EpochTime"=>1610169000, "WeatherText"=>"Intermittent Clouds",
  #            "WeatherIcon"=>35, "HasPrecipitation"=>false,
  #            "PrecipitationType"=>nil, "IsDayTime"=>false,
  #            "Temperature"=>{"Metric"=>{"Value"=>-7.2, "Unit"=>"C", "UnitType"=>17},
  #            "Imperial"=>{"Value"=>19.0, "Unit"=>"F", "UnitType"=>18}},
  #            "MobileLink"=>"http://m.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us",
  #            "Link"=>"http://www.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us"}]
  #   hazy = [{"LocalObservationDateTime"=>"2021-01-08T22:10:00-07:00",
  #            "EpochTime"=>1610169000, "WeatherText"=>"Hazy Sunshine",
  #            "WeatherIcon"=>35, "HasPrecipitation"=>false,
  #            "PrecipitationType"=>nil, "IsDayTime"=>false,
  #            "Temperature"=>{"Metric"=>{"Value"=>-7.2, "Unit"=>"C", "UnitType"=>17},
  #            "Imperial"=>{"Value"=>19.0, "Unit"=>"F", "UnitType"=>18}},
  #            "MobileLink"=>"http://m.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us",
  #            "Link"=>"http://www.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us"}]
  #   mostly_cloudy = [{"LocalObservationDateTime"=>"2021-01-08T22:10:00-07:00",
  #            "EpochTime"=>1610169000, "WeatherText"=>"Mostly Cloudy",
  #            "WeatherIcon"=>35, "HasPrecipitation"=>false,
  #            "PrecipitationType"=>nil, "IsDayTime"=>false,
  #            "Temperature"=>{"Metric"=>{"Value"=>-7.2, "Unit"=>"C", "UnitType"=>17},
  #            "Imperial"=>{"Value"=>19.0, "Unit"=>"F", "UnitType"=>18}},
  #            "MobileLink"=>"http://m.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us",
  #            "Link"=>"http://www.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us"}]
  #   dreary = [{"LocalObservationDateTime"=>"2021-01-08T22:10:00-07:00",
  #            "EpochTime"=>1610169000, "WeatherText"=>"Dreary (Overcast)",
  #            "WeatherIcon"=>35, "HasPrecipitation"=>false,
  #            "PrecipitationType"=>nil, "IsDayTime"=>false,
  #            "Temperature"=>{"Metric"=>{"Value"=>-7.2, "Unit"=>"C", "UnitType"=>17},
  #            "Imperial"=>{"Value"=>19.0, "Unit"=>"F", "UnitType"=>18}},
  #            "MobileLink"=>"http://m.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us",
  #            "Link"=>"http://www.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us"}]
  #   rainy = [{"LocalObservationDateTime"=>"2021-01-08T22:10:00-07:00",
  #            "EpochTime"=>1610169000, "WeatherText"=>"Showers",
  #            "WeatherIcon"=>35, "HasPrecipitation"=>false,
  #            "PrecipitationType"=>nil, "IsDayTime"=>false,
  #            "Temperature"=>{"Metric"=>{"Value"=>-7.2, "Unit"=>"C", "UnitType"=>17},
  #            "Imperial"=>{"Value"=>19.0, "Unit"=>"F", "UnitType"=>18}},
  #            "MobileLink"=>"http://m.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us",
  #            "Link"=>"http://www.accuweather.com/en/us/aspen-co/81611/current-weather/332154?lang=en-us"}]

  #   showers = Weather.conditions_parse(rainy)
  #   mostly = Weather.conditions_parse(most)
  #   snow = Weather.conditions_parse(some_snow)
  #   sunny = Weather.conditions_parse(some_sun)
  #   cloudy = Weather.conditions_parse(int_clouds)
  #   very_cloudy = Weather.conditions_parse(mostly_cloudy)
  #   grey = Weather.conditions_parse(dreary)
    
  #   expect(showers).to eq("Rain")
  #   expect(mostly).to eq("Clear")
  #   expect(snow).to eq("Snow")
  #   expect(sunny).to eq("Sunny")
  #   expect(cloudy).to eq("Cloudy")
  #   # expect(hazy).to eq("Sunny") #come back to this one
  #   expect(very_cloudy).to eq("Cloudy")
  #   expect(grey).to eq("Cloudy")
  # end
end



[#<OpenStruct Version=1, Key="333556", Type="City", Rank=55, LocalizedName="Aspen Hill", Country=#<OpenStruct ID="US", LocalizedName="United States">, AdministrativeArea=#<OpenStruct ID="MD", LocalizedName="Maryland">>, #<OpenStruct Version=1, Key="16151", Type="City", Rank=75, LocalizedName="Aspendale", Country=#<OpenStruct ID="AU", LocalizedName="Australia">, AdministrativeArea=#<OpenStruct ID="VIC", LocalizedName="Victoria">>, #<OpenStruct Version=1, Key="3497571", Type="City", Rank=75, LocalizedName="Aspendale Gardens", Country=#<OpenStruct ID="AU", LocalizedName="Australia">, AdministrativeArea=#<OpenStruct ID="VIC", LocalizedName="Victoria">>, #<OpenStruct Version=1, Key="3379759", Type="City", Rank=75, LocalizedName="Aspen Woods", Country=#<OpenStruct ID="CA", LocalizedName="Canada">, AdministrativeArea=#<OpenStruct ID="AB", LocalizedName="Alberta">>, #<OpenStruct Version=1, Key="332154", Type="City", Rank=75, LocalizedName="Aspen", Country=#<OpenStruct ID="US", LocalizedName="United States">, AdministrativeArea=#<OpenStruct ID="CO", LocalizedName="Colorado">>, #<OpenStruct Version=1, Key="175703", Type="City", Rank=83, LocalizedName="Aspenstedt", Country=#<OpenStruct ID="DE", LocalizedName="Germany">, AdministrativeArea=#<OpenStruct ID="ST", LocalizedName="Saxony-Anhalt">>, #<OpenStruct Version=1, Key="53167", Type="City", Rank=85, LocalizedName="Aspen Grove", Country=#<OpenStruct ID="CA", LocalizedName="Canada">, AdministrativeArea=#<OpenStruct ID="BC", LocalizedName="British Columbia">>, #<OpenStruct Version=1, Key="2295462", Type="City", Rank=85, LocalizedName="Aspen Park", Country=#<OpenStruct ID="CA", LocalizedName="Canada">, AdministrativeArea=#<OpenStruct ID="MB", LocalizedName="Manitoba">>, #<OpenStruct Version=1, Key="2178877", Type="City", Rank=85, LocalizedName="Aspen Springs", Country=#<OpenStruct ID="US", LocalizedName="United States">, AdministrativeArea=#<OpenStruct ID="CA", LocalizedName="California">>, #<OpenStruct Version=1, Key="2201318", Type="City", Rank=85, LocalizedName="Aspen Park", Country=#<OpenStruct ID="US", LocalizedName="United States">, AdministrativeArea=#<OpenStruct ID="CO", LocalizedName="Colorado">>]