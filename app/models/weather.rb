# frozen_string_literal: true

class Weather < OpenStruct

  def self.service
    @@service ||= WeatherService.new
  end

  def self.error_handling(input)
    unless input.is_a?(Array)
      true
    else
      false
    end
  end

  def self.output_parse(input)
    input.first
  end

  def self.metric(input)
    data = output_parse(input)
    temp = data[:Temperature][:Metric][:Value]
    temp.nil? ? 'Error' : temp
  end

  def self.imperial(input)
    data = output_parse(input)
    temp = data[:Temperature][:Imperial][:Value]
    temp.nil? ? 'Error' : temp
  end

  def self.precipitation(input)
    # Still needs a test
    precip = output_parse(input)
    precip[:PrecipitationType]
  end

  def self.conditions_adjust(temperature)
    temp = imperial(temperature)
    condition = conditions_parse(temperature)

    case condition
    when 'Sunny'
      temp += 3
    when 'Snow'
      temp +- 7
    when 'Rain'
      temp += 5
    when 'Clear'
      temp +- 2
    when 'Cold'
      temp +- 7
    when 'Hot'
      temp += 10
    when 'Recent Snow'
      temp +- 10
    else
      temp
    end
  end

  def self.description(temperature)
    updated_temp = conditions_adjust(temperature)
    case updated_temp
    when -22..10
      "When new snow is present, it's extra cold and coarse. The coldest waxes will be your best option"
    when 15..32
      'If things stay sunny, consider the warmer wax only, if temps start dropping, consider mixing some colder wax 50-50.'
    when 32..36
      'Still need a good description for this'
    when 37..60
      'Look for your warmest wax and some wet struture to add to the ski'
    when 60..100
      'Are you really going skiing?'
    else
      'An Error has occured, please try again'
    end
  end

  def self.toko_temp_range(temp)
    case temp
    when -22..10
      'Blue'
    when 11..18
      'Blue/Red'
    when 19..24
      'Red'
    when 25..29
      'Red/Yellow'
    when 29..100
      'Yellow'
    else
      'Error, Please try me again'
    end
  end

  def self.conditions_parse(text)
    weather = output_parse(text)
    data = weather[:WeatherText]

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
    # This is based of air temp
    temp = imperial(input)

    case temp
    when -22..14
      'blue'
    when 15..36
      'red'
    when 37..60
      'yellow'
    when 60..100
      "Are you sure you're XC skiing?"
    else
      'please refresh data'
    end
  end

  def self.swix_description(temp)
    # This will be extracted into a different model
    case temp
    when -25..10
      'CH4 Green'
    when 11..15
      'CH5 Turquoise'
    when 15..23
      'CH6 Blue'
    when 24..31
      'CH7 Violet'
    when 32..50
      'CH10 Yellow'
    else
      'please refresh data'
    end
  end

  def self.swix_color(temp)
    #This is only here for info before moving into a seperate model
    case temp
    when -25..10
      'green'
    when 11..15
      'turquoise'
    when 15..23
      'blue'
    when 24..31
      'violet'
    when 32..50
      'yellow'
    else
      'please refresh data'
    end
  end
end
