class Topic < ApplicationRecord
  self.implicit_order_column = "created_at"

  belongs_to :talk

  has_many :votes, dependent: :destroy

  validates :content, presence: { message: "Oops! Looks like you forgot to write a topic"}
  validates :content, length: { maximum: 1000, too_long: "Are you sure the other participants want to read a novel? Try shortening your topic a bit"}
  
  after_commit :broadcast_content, on: :update

  after_destroy :broadcast_content

  def broadcast_content
    talk.broadcast_content
  end
end

