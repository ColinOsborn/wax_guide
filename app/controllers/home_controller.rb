class HomeController < ApplicationController
  def index; end

  def search
    @search_query = params[:location]
    if @search_query.empty?
      flash[:danger] = 'Not Valid, please try again'
    else
      @output = Weather.service.get_autocomplete_search(@search_query)
    end
  end

  def location
    @location_query = params[:location].pop
    @output = Weather.service.get_current_conditions(@location_query)
  end
end
