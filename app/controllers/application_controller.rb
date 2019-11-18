class ApplicationController < ActionController::Base
  include StoreLocations

  include ErrorHandlers

  before_action :authenticate_user!
  before_action :set_host #パスワード再設定用

  def set_host #パスワード再設定用
    Rails.application.routes.default_url_options[:host] = request.host_with_port
  end
end
