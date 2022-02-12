module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_visitor

    def connect
      self.current_visitor = session[:visitor_id]
    end

    def session
      @request.session
    end
  end
end
