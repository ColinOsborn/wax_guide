class SearchController < ApplicationController
  
    def index
        @location = Location.find(params[:q])
    end

    def show
        @location = Location.find(params[:q])
    end

end