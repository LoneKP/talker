class Talk < ApplicationRecord
  include Moderated

  has_many :topics, dependent: :destroy

  validates :host, presence: { message: "Don't be shy! Write your name to let the participants know who you are"}
  validates :theme, presence: { message: "Write an overall theme of the talk"}
  validates :duration, presence: { message: "How long time do you plan to spend?"}

  after_commit :broadcast_content, if: :saved_change_to_state?


  def broadcast_content
    broadcast_replace_later_to "state_stream", target: ActionView::RecordIdentifier.dom_id(self), partial: "talks/partial_show", 
    locals: { talk: self, topics: self.ordered_topics.to_a } 
  end

  def ordered_topics
    if state < 4
      topics.order(created_at: :desc)
    else
      topics_by_votes
    end
  end

  def topics_by_votes
    topics.left_joins(:votes).group("topics.id").order("count(topics.id) DESC")
  end

  def highest_voted_topic
    topics_by_votes[0]
  end

  def current_topic
    topics_by_votes.find_by(current:true)
  end

  def all_topics_are_done?
    !topics.where(done:false).any? && topics.size > 0
  end

  def time_for_amount_of_topics
    return 0 if duration.nil?

    (duration - intro_duration)/per_topic_duration 
  end

  private

  def per_topic_duration
    8
  end

  def intro_duration
    10
  end

end
