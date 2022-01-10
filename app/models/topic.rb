class Topic < ApplicationRecord
  belongs_to :talk
  has_many :votes, dependent: :destroy

  validates :content, presence: { message: "Oops! Looks like you forgot to write a topic"}

  after_create_commit { broadcast_prepend_later_to "topics_stream", locals: { talk: self.talk} }

  after_create_commit { broadcast_replace_later_to "topic_count_stream", target: "topics_count", partial: "topics/index", locals: { talk: self.talk } }

  after_commit :broadcast_content, if: :saved_change_to_current?

  def broadcast_content
    talk.broadcast_content
  end
end

