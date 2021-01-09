require 'rails_helper'

RSpec.describe Weather, type: :model do
  it "provides correct wax (toko) description" do

    # true_blue = Weather.description(12, "Sunny")
    not_red_blue = Weather.description(17, "Snow")
    # warm = Weather.description(yellow)
    
    # expect(true_blue).to eq("Toko Blue")
    expect(not_red_blue).to eq("Toko Blue. When new snow is present, it's extra cold and coarse.")
    # expect(warm).to eq("Toko Yellow. The range for the yellow wax goes from 25F on up. If it's a hot day and been a while since it's snowed, Yellow is the way to go.")
  end

  it "provides correct wax (toko) color" do
    blue = 12
    red = 22
    yellow = 32

    cold = Weather.color(blue)
    med = Weather.color(red)
    warm = Weather.color(yellow)

    expect(cold).to eq("blue")
    expect(med).to eq("red")
    expect(warm).to eq("yellow")
  end

  it "provides correct swix wax description" do
    green = 0
    turquoise = 12
    blue = 17
    violet = 27
    yellow = 40

    frigid = Weather.swix_description(green)
    frozen = Weather.swix_description(turquoise)
    cold = Weather.swix_description(blue)
    slight_cold = Weather.swix_description(violet)
    warm = Weather.swix_description(yellow)

    expect(frigid).to eq("CH4 Green")
    expect(frozen).to eq("CH5 Turquoise")
    expect(cold).to eq("CH6 Blue")
    expect(slight_cold).to eq("CH7 Violet")
    expect(warm).to eq("CH10 Yellow")
  end

  it "parses weather text and conditions" do
    most = Weather.conditions_parse("Mostly Clear")
    some_snow = Weather.conditions_parse("Mostly Cloudy w/ Snow")
    some_sun = Weather.conditions_parse("Partly Sunny")
    int_clouds = Weather.conditions_parse("Intermittent Clouds")
    hazy = Weather.conditions_parse("Hazy Sunshine")
    mostly_cloudy = Weather.conditions_parse("Mostly Cloudy")
    dreary = Weather.conditions_parse("Dreary (Overcast)")

    expect(most).to eq("Clear")
    expect(some_snow).to eq("Snow")
    expect(some_sun).to eq("Sunny")
    expect(int_clouds).to eq("Cloudy")
    expect(hazy).to eq("Sunny") #come back to this one
    expect(mostly_cloudy).to eq("Cloudy")
    expect(dreary).to eq("Cloudy")
  end
end


