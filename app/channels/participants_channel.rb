class ParticipantsChannel < ApplicationCable::Channel
  def subscribed
    if !current_visitor.nil?
      @talk = Talk.find(params[:id])
      REDIS.sadd "online", current_visitor
      @talk.broadcast_participants
    end
  end

  def unsubscribed
    @talk = Talk.find(params[:id])
    REDIS.srem "online", current_visitor
    @talk.broadcast_participants
  end
end
