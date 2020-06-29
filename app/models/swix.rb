class Swix < ApplicationRecord

    def temperature_new(temp)
        case temp
        when -25..10
            "CH4X Green"
        when 11..15
            "CH5X Turquoise"
        when 15..23
            "CH6X Blue"
        when 24..31
            "CH7X Violet"
        when 32..50
            "CH10X Yellow"
        else
            "please refresh data"
        end
    end  
end
