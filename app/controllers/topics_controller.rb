class TopicsController < ApplicationController
  include TalkScoped, ActionView::RecordIdentifier

  before_action :set_topic, only: [:update, :edit, :destroy]
  skip_before_action :verify_authenticity_token

  def create
    @topic = @talk.topics.new topic_params
    @topics = @talk.ordered_topics
    if @topic.save
      redirect_to @talk
    else
      respond_to do |format|
        format.html { render "talks/show", status: :unprocessable_entity }
      end
    end
  end 

  def edit
  end

  def upvote
    Topic.find(params[:topic_id]).votes.create!
  end

  def destroy
    if @topic.destroy
      render @talk
    else
      respond_to do |format|
        format.html { render "talks/show", status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to talk_url(@talk) }
      else
        format.html { }
      end
    end
  end

  private 
  def topic_params
    params.required(:topic).permit(:content)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end
end
