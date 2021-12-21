class TopicsController < ApplicationController
  before_action :set_talk

  def create
    @talk.topics.create! params.required(:topic).permit(:content)
    redirect_to @talk
  end 

  private
  def set_talk
    @talk = Talk.find(params[:talk_id])
  end
end
