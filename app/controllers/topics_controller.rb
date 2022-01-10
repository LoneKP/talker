class TopicsController < ApplicationController
  before_action :set_talk
  before_action :set_topic, only: :update
  skip_before_action :verify_authenticity_token

  def create
    @topic = @talk.topics.new topic_params
    @topics = @talk.ordered_topics
    if @topic.save
      redirect_to @talk
    else
      respond_to do |format|
        format.html { render "talks/show", status: :unprocessable_entity }
        flash.now[:error] = @topic.errors.messages.first.second[0]
      end
    end
  end 

  def upvote
    Topic.find(params[:topic_id]).votes.create!
  end

  def update
   @topic.toggle(:done)
   @topic.save
  end

  private 
  def topic_params
    params.required(:topic).permit(:content)
  end

  def set_talk
    @talk = Talk.find(params[:talk_id])
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end
end
