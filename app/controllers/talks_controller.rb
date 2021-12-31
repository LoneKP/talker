class TalksController < ApplicationController
  before_action :set_talk, only: %i[ show edit update destroy ]
 
  # GET /talks/1 or /talks/1.json
  def show
    @topics = @talk.ordered_topics
    @topic = Topic.new
  end

  # GET /talks/new
  def new
    @talk = Talk.new
  end

  # GET /talks/1/edit
  def edit
  end

  # POST /talks or /talks.json
  def create
    @talk = Talk.new(talk_params)

    respond_to do |format|
      if @talk.save
        format.html { redirect_to talk_url(@talk), notice: "Talk was successfully created." }
        format.json { render :show, status: :created, location: @talk }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @talk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /talks/1 or /talks/1.json
  def update
    if @talk.update(talk_params)
      #Page change is streamed from talk.rb
    else
      render "talks/show", status: :unprocessable_entity
      flash.now[:error] = "something happened"
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_talk
      @talk = Talk.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def talk_params
      params.require(:talk).permit(:duration, :host, :state)
    end
end
