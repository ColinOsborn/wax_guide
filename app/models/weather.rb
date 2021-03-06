class Weather < OpenStruct
  require 'pry'

  def self.service
    @@service ||= WeatherService.new
  end

  def self.error_handling(input)
    code = input.first
    code.include?("Unauthorized")
  end

  def self.output_parse(input)
    input.first
  end

  def self.metric(input)
    data = output_parse(input)
    temp = data["Temperature"]["Metric"]["Value"]
    temp.nil? ? "Error" : temp
  end

  def self.imperial(input)
    data = output_parse(input)
    temp = data["Temperature"]["Imperial"]["Value"]
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
    initial = temp

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
    data = weather["WeatherText"]

    conditions_hash = {
      "Rain" => ["Showers", "Mostly Cloudy w/ Showers", "Partly Sunny w/ Showers", "T-Storms", "Mostly Cloudy w/ T-Storms", 
      "Partly Sunny w/ T-Storms", "Rain", "Flurries", "Mostly Cloudy w/ Flurries", "Partly Sunny w/ Flurries", "Sleet", "Freezing Rain", 
      "Mostly Cloudy w/ Flurries", "Mostly Cloudy w/ T-Storms", "Partly Cloudy w/ T-Storms", "Mostly Cloudy w/ Showers", "Partly Cloudy w/ Showers", "Mostly Cloudy"],
      "Snow" => ["Snow", "Mostly Cloudy w/ Snow", "Ice", "Rain and Snow", "Mostly Cloudy w/ Snow", "Mostly Cloudy w/ Flurries"],
      "Cloudy" => ["Intermittent Clouds", "Mostly Cloudy", "Cloudy", "Dreary (Overcast)", "Fog", "Partly Cloudy", "Intermittent Clouds"],
      "Clear" => ["Clear", "Mostly Clear"],
      "Sunny" => ["Sunny", "Mostly Sunny", "Partly Sunny", "Hazy Sunshine"],
      "Hot" => ["Hot"],
      "Cold" => ["Cold"],
    }

    parsed_conditions = []
    conditions_hash.each do |key, value|
      parsed_conditions << key if value.find { |l| l == data }
    end
    parsed_conditions.pop
  end

  def self.color(input)
    temp = metric(input)
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
end
