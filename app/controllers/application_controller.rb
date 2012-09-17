class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def getIp
    getIp = request.remote_ip
  end

end
