class Talk < ApplicationRecord
  validates_presence_of :host
  has_many :topics, dependent: :destroy
end
