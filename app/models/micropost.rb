class Micropost < ApplicationRecord
  belongs_to :user
  has_many :choices
  scope :sorted_desc, -> { order(created_at: :desc) }
  has_one_attached :image
  validates :content, presence: true, length: { maximum: 140 }
  accepts_nested_attributes_for :choices, allow_destroy: true
end
