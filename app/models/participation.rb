class Participation < ApplicationRecord
  self.implicit_order_column = "created_at"

  belongs_to :visitor
  belongs_to :talk

  scope :talk_and_visitor_participation, ->(talk, visitor) { where(talk: talk, visitor: visitor) }
end