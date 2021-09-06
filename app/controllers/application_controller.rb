class ApplicationController < ActionController::Base
  include DeviseWhitelist
  include CurrentUserConcern
  before_action :configure_permitted_parameters, if: :devise_controller?
end
