class Topic < ApplicationRecord
  belongs_to :talk
  broadcasts_to :talk ,inserts_by: :prepend

  validates :content, presence: { message: "Oops! looks like you forgot to write a topic"}

  after_create_commit { broadcast_replace_later_to "topic_count_stream", target: "topics_count", partial: "topics/index", 
    locals: { talk: self.talk } }
end
