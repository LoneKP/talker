class Topic < ApplicationRecord
  belongs_to :talk
  broadcasts_to :talk
end
