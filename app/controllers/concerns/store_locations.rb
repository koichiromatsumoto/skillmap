module StoreLocations
  extend ActiveSupport::Concern

  included do
    after_action :store_location
  end

  private

  def store_location
    if !ignore_url_list.include?(request.fullpath) && !request.xhr?
      session[:previous_url] = request.fullpath
    end
  end

  def ignore_url_list
    []
  end

  def previous_url
    session[:previous_url]
  end
end
