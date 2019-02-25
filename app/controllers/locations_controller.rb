class LocationsController < ApplicationController

    def show
        byebug
        @location = Location.find(params[:id])
    end

    def index
    end

end