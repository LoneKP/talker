module TalkScoped
  extend ActiveSupport::Concern

  included do
    before_action :scope_by_talk
  end

  private

  def scope_by_talk
    if id = params[:talk_id] || params[:id]
      @talk = Talk.find_by! id: id
    end
  end
end
