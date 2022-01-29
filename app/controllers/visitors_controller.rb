class VisitorsController < ApplicationController
  include TalkScoped

  def new
  end

  def create
    if Current.visitor
      @visitor = Visitor.find(Current.visitor.id)
      @visitor.attributes = visitor_params
    else
      @visitor = Visitor.new(visitor_params)
    end
    respond_to do |format|
      if @visitor.save
        session[:visitor_id] = @visitor.id
        @talk.visitors << @visitor unless @talk.visitors.exists?(@visitor.id)
        format.html { redirect_to talk_url(@talk) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def current_visitor
    render json: Participation.current(@talk, Current.visitor)[0].as_json
  end

  def visitor_params
    params.require(:visitor).permit(:name, :talk_id)
  end


end