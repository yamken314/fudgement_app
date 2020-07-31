class Micropost < ApplicationRecord
  belongs_to :user
  scope :sorted_desc, -> { order(created_at: :desc) }
  has_many_attached :images
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
