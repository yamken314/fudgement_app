class Choice < ApplicationRecord
  belongs_to :micropost
  has_many :votes, dependent: :destroy
  validates_presence_of :micropost
end
