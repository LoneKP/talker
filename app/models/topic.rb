class Topic < ApplicationRecord
  belongs_to :talk
  has_many :votes, dependent: :destroy

  validates :content, presence: { message: "Oops! Looks like you forgot to write a topic"}
  validates :content, length: { maximum: 1000, too_long: "Are you sure the other participants want to read a novel? Try shortening your topic a bit"}

  after_create_commit { broadcast_prepend_later_to "topics_stream", locals: { talk: self.talk} }

  after_create_commit { broadcast_replace_later_to "topic_count_stream", target: "topics_count", partial: "topics/index", locals: { talk: self.talk } }

  after_commit :broadcast_content, if: :saved_change_to_current?

  def broadcast_content
    talk.broadcast_content
  end
end

