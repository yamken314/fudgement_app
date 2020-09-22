class Choice < ApplicationRecord
  belongs_to :micropost
  has_many :votes, dependent: :destroy
  validates_presence_of :micropost
  validates :name, presence: true, length: { maximum: 140 }
  belongs_to :user
end
