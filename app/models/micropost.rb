class Micropost < ApplicationRecord
  belongs_to :user
  has_many :choices
  accepts_nested_attributes_for :choices
  scope :sorted_desc, -> { order(created_at: :desc) }
  has_many_attached :images
  validates :content, presence: true, length: { maximum: 140 }
end
