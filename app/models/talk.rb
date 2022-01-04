class Talk < ApplicationRecord
  has_many :topics, dependent: :destroy

  validates :host, presence: { message: "Don't be shy! Write your name to let the participants know who you are."}

  after_commit :broadcast_state, if: :saved_change_to_state?

  def broadcast_state
    broadcast_replace_later_to "state_stream", target: ActionView::RecordIdentifier.dom_id(self), partial: "talks/partial_show", 
    locals: { talk: self, topics: self.ordered_topics.to_a } 
  end

  def ordered_topics
    if state < 4
      topics_by_created_at
    else
      topics_by_votes
    end
  end

  def topics_by_created_at
    topics.order(created_at: :desc)
  end

  def topics_by_votes
    topics.left_joins(:votes).group("topics.id").order("count(topics.id) DESC") 
  end
end
