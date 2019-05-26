class ApplicationController < ActionController::Base
  include StoreLocations

  include ErrorHandlers

  before_action :authenticate_user!
end
