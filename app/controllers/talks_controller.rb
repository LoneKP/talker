class TalksController < ApplicationController
  include TalkScoped

  skip_before_action :verify_authenticity_token
 
  before_action :require_visitor_registrated!, only: :show
 
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
    @visitor = Current.visitor || @talk.visitors.build
  end

  def create
    @talk = Talk.new(talk_params)
    @visitor = Visitor.find_or_initialize_by(id: visitors_params[:visitors_attributes]["0"][:id], name: visitors_params[:visitors_attributes]["0"][:name] )
    respond_to do |format|
      if @talk.save && @visitor.valid?
        @talk.visitors << @visitor
        @participation = Participation.talk_and_visitor_participation(@talk, @visitor)
        @participation.update(facilitator:true)
        session[:visitor_id] = @visitor.id
        format.html { redirect_to talk_url(@talk), notice: "Wonderful. Let's get started!" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    @visitor = Visitor.find_by(id: visitors_params[:visitors_attributes]["0"][:id], name: visitors_params[:visitors_attributes]["0"][:name] )
    respond_to do |format|
      if @talk.update(talk_and_visitors_params)
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
    # Only allow a list of trusted parameters through.
    def talk_params
      params.require(:talk).permit(:duration, :state, :theme)
      end
    
    def visitors_params
      params.require(:talk).permit(visitors_attributes: [:name, :id])
    end

    def talk_and_visitors_params
      params.require(:talk).permit(:duration, :state, :theme, visitors_attributes: [:name, :id])
    end
end
