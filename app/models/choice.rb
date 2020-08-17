class Choice < ApplicationRecord
  belongs_to :micropost
  has_many :votes
end
