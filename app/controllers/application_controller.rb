class ApplicationController < ActionController::Base
  before_action :set_current_visitor
  
  #private

  def set_current_visitor
    Current.visitor = Visitor.find_by(id: session[:visitor_id]) if session[:visitor_id]
  end

  def require_visitor_registrated!
    redirect_to new_talk_visitor_path(talk_id: params[:id]) unless @talk.visitors.exists?(Current.visitor&.id)
  end
end
