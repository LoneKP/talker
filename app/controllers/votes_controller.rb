class VotesController < ApplicationController
  before_action :set_talk

  def index
    @topics = @talk.topics.order(created_at: :desc)
  end

  private

  def set_talk
    @talk = Talk.find(params[:talk_id])
  end
end
