class TalksController < ApplicationController
  before_action :set_talk, only: %i[ show edit update destroy update_current_topic ]
  before_action :set_visitor_id, only: %i[ create show ]
  skip_before_action :verify_authenticity_token
 
  # GET /talks/1 or /talks/1.json
  def show
    @topics = @talk.ordered_topics
    @topic = Topic.new
  end

  def index
  end

  def edit
  end

  # GET /talks/new
  def new
    @talk = Talk.new
  end

  # POST /talks or /talks.json
  def create
    @talk = Talk.new(talk_params)
    cookies[:facilitator_id] = @visitor_id
    respond_to do |format|
      if @talk.save
        format.html { redirect_to talk_url(@talk), notice: "Wonderful. Let's get started!" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @talk.update(talk_params)
        format.html { redirect_to talk_url(@talk) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /talks/1 or /talks/1.json
  def destroy
    @talk.destroy

    respond_to do |format|
      format.html { redirect_to talks_url, notice: "Talk was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def update_current_topic
    case params[:direction]
      when "next"
        @talk.moderator.set_next_topic
      when "back"
        @talk.moderator.set_previous_topic
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_talk
      if talk_id = params[:id] || params[:talk_id]
        @talk = Talk.find(talk_id)
      end
    end

    # Only allow a list of trusted parameters through.
    def talk_params
      params.require(:talk).permit(:duration, :host, :state, :theme)
    end
end
