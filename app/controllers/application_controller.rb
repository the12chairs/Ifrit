class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :store_request

  def store_request
    Thread.current[:request] = request
  end

end
