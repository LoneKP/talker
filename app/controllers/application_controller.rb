class ApplicationController < ActionController::Base
  before_action :set_talk

  def set_talk
    @talk = Talk.find(params[:id])
  end
end
