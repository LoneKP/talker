class Visitor < ApplicationRecord
  self.implicit_order_column = "created_at"
  
  has_many :participations
  has_many :talks, -> { distinct }, through: :participations

  scope :participants, -> { joins(:participations).where(participations: { facilitator: false }) }
  
  validates :name, presence: { message: "What is your name?" }

  def facilitator?(talk)
    return "no active talk" if participations.find_by(talk: talk).nil?
    participations.find_by(talk: talk).facilitator
  end

  def of talk
    participations.find_by(talk: talk)
  end
end