class Vote < ApplicationRecord
  belongs_to :topic

  after_create_commit { broadcast_replace_later_to "vote_count_stream", target: ActionView::RecordIdentifier.dom_id(self.topic, :votes_count), partial: "votes/votes", 
    locals: { topic: self.topic } }
end