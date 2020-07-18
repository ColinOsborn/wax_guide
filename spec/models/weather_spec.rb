require 'rails_helper'

RSpec.describe Weather, type: :model do
  it "provides correct wax (toko) description" do
    blue = 12
    red = 22
    yellow = 32

    cold = Weather.description(blue)
    med = Weather.description(red)
    warm = Weather.description(yellow)
    
    expect(cold).to eq("Toko Blue")
    expect(med).to eq("Toko Red. If snow has fallen in the past 2-3 days and temps looking to dropping, consider mixing Toko Blue.")
    expect(warm).to eq("Toko Yellow. The range for the yellow wax goes from 25F on up. If it's a hot day and been a while since it's snowed, Yellow is the way to go.")
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
end


