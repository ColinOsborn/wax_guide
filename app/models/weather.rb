class Weather < OpenStruct
  require 'pry'

  def self.service
    @@service ||= WeatherService.new
  end

  def self.output_parse(input)
    input.first
  end

  def self.metric(input)
    parse = output_parse(input)
    temp = parse["Temperature"]["Metric"]["Value"]
    temp.nil? ? "Error" : temp
  end

  def self.imperial(input)
    parse = output_parse(input)
    temp = parse["Temperature"]["Imperial"]["Value"]
    temp.nil? ? "Error" : temp
  end

  def self.precipitation(input)
    precip = output_parse(input)
    precip["PrecipitationType"]
    # Still needs a test
  end

  def self.description(temperature, conditions)
    parsed_temp = imperial(temperature)
    temp = toko_temp_range(parsed_temp)
    condition = conditions_parse(conditions)

    if "Blue" && "Sunny"
      "Toko Blue"
    elsif "Blue/Red" && "Snow"
      "Toko Blue. When new snow is present, it's extra cold and coarse."
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
    else nil || nil
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

  def self.conditions_parse(text)
    weather = output_parse(text)
        #windy? 
        # conditions_hash = 
        #    "Rain" => ["Showers", "Mostly Cloudy w/ Showers", "Partly Sunny w/ Showers", "T-Storms", "Mostly Cloudy w/ T-Storms", "Partly Sunny w/ T-Storms", "Rain", "Flurries", "Mostly Cloudy w/ Flurries", "Partly Sunny w/ Flurries", "Sleet", "Freezing Rain", "Mostly Cloudy w/ Flurries", "Mostly Cloudy w/ T-Storms", "Partly Cloudy w/ T-Storms", "Mostly Cloudy w/ Showers", "Partly Cloudy w/ Showers", "Mostly Cloudy"],
        #    "Snow" => ["Snow", "Mostly Cloudy w/ Snow", "Ice", "Rain and Snow", "Mostly Cloudy w/ Snow", "Mostly Cloudy w/ Flurries"],
        #    "Cloudy" => ["Intermittent Clouds", "Mostly Cloudy", "Cloudy", "Dreary (Overcast)", "Fog", "Partly Cloudy", "Intermittent Clouds"],
        #    "Clear" => ["Clear", "Mostly Clear"],
        #    "Sunny" => ["Sunny", "Mostly Sunny", "Partly Sunny", "Hazy Sunshine"],
        #    "Hot" => ["Hot"],
        #    "Cold" => ["Cold"],
        # 
    conditions_hash = {
      "Showers" => "Rain", 
      "Mostly Cloudy w/ Showers" => "Rain", 
      "Partly Sunny w/ Showers" => "Rain",
      "T-Storms" => "Rain",
      "Mostly Cloudy w/ T-Storms" => "Rain",
      "Partly Sunny w/ T-Storms" => "Rain", 
      "Rain" => "Rain",
      "Flurries" => "Rain",
      "Mostly Cloudy w/ Flurries" => "Rain",
      "Partly Sunny w/ Flurries" => "Rain",
      "Sleet" => "Rain",
      "Freezing Rain" => "Rain",
      "Mostly Cloudy w/ Flurries" => "Rain",
      "Mostly Cloudy w/ T-Storms" => "Rain",
      "Partly Cloudy w/ T-Storms" => "Rain",
      "Mostly Cloudy w/ Showers" => "Rain",
      "Partly Cloudy w/ Showers" => "Rain",
      "Mostly Cloudy" => "Rain",
      "Snow" => "Snow",
      "Mostly Cloudy w/ Snow" => "Snow",
      "Ice" => "Snow",
      "Rain and Snow" => "Snow",
      "Mostly Cloudy w/ Snow" => "Snow",
      "Mostly Cloudy w/ Flurries" => "Snow",
      "Intermittent Clouds" => "Cloudy",
      "Mostly Cloudy" => "Cloudy",
      "Cloudy" => "Cloudy",
      "Dreary (Overcast)" => "Cloudy",
      "Fog" => "Cloudy",
      "Partly Cloudy" => "Cloudy",
      "Intermittent Clouds" => "Cloudy",
      "Clear" => "Clear",
      "Mostly Clear" => "Clear",
      "Sunny" => "Sunny",
      "Mostly Sunny" => "Sunny",
      "Partly Sunny" => "Sunny",
      "Hazy Sunshine" => "Sunny",
      "Hot" => "Hot",
      "Cold" => "Cold",
    }

    parsed_conditions = conditions_hash.select do |key, value|
      return value if key == weather
    end
    parsed_conditions
  end

  def self.color(input)
    temp = imperial(input)
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
