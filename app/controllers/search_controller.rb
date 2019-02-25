class SearchController < ApplicationController
  
    def index
        @location = Location.all(params[:q])

        # @total = Store.total(params[:q])
        # # @stores = Store.all(params[:q])["stores"]
        # @stores = Store.all(params[:q])
    end

end