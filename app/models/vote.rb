class Vote < ApplicationRecord
  belongs_to :topic

    after_commit :broadcast_content, on: :create

  def broadcast_content
    topic.talk.broadcast_content
  end
end