class Choice < ApplicationRecord
  belongs_to :micropost
  has_many :votes
  validates_presence_of :micropost
end
