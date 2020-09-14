class Micropost < ApplicationRecord
  belongs_to :user
  has_many :choices
  scope :sorted_desc, -> { order(created_at: :desc) }
  has_many_attached :images
  validates :content, presence: true, length: { maximum: 140 }
  accepts_nested_attributes_for :choices, allow_destroy: true
end
