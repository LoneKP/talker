class Talk < ApplicationRecord
  self.implicit_order_column = "created_at"
  
  include Moderated

  has_many :topics, dependent: :destroy
  
  has_many :participations, dependent: :destroy
  has_many :visitors, -> { distinct }, through: :participations

  accepts_nested_attributes_for :visitors

  validates :theme, presence: { message: "Write an overall theme of the talk"}
  
  validates :duration, presence: { message: "How long time do you plan to spend?"}
  validates :duration, numericality: { only_integer: true, message: "How long time do you plan to spend in minutes?" }

  after_update_commit :broadcast_content
  
  after_update_commit :set_first_topic, if: :state_is_4_and_there_is_no_current_topic?

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

  def facilitator
    participations.find_by(facilitator:true).visitor
  end

  private

  def state_is_4_and_there_is_no_current_topic?
    moderator.there_is_no_current_topic? && state == 4
  end

  def set_first_topic
    moderator.set_first_topic
  end
end
