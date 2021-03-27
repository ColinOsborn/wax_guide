class HomeController < ApplicationController
  def index; end

  def zipcode
    @zip_query = params[:zipcode]
    if @zip_query.nil?
      flash[:danger] = 'Not Valid, please try again'
    else
      @output = Weather.service.get_autocomplete_search(@zip_query)
    end
  end

  def location
    @location_query = params[:location].pop
    @output = Weather.service.get_current_conditions(@location_query)
  end
end
