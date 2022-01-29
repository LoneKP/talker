class Participation < ApplicationRecord
  self.implicit_order_column = "created_at"

  belongs_to :visitor
  belongs_to :talk

  scope :current, ->(talk, visitor) { where(talk: talk, visitor: visitor) }
end