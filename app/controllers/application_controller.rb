class ApplicationController < ActionController::Base

  #private

  def set_visitor_id
    @visitor_id = cookies[:visitor_id] ||= SecureRandom.uuid
  end

end
