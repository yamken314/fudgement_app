class Micropost < ApplicationRecord
  belongs_to :user
  has_many :choices
  scope :sorted_desc, -> { order(created_at: :desc) }
  has_one_attached :image
  validates :content, presence: true, length: { maximum: 140 }
  accepts_nested_attributes_for :choices, allow_destroy: true
  validate  :validate_image

  def validate_image
    return unless image.attached?

    if image.blob.byte_size > 10.megabytes
      image.purge
      errors.add(:image, 'ファイルのサイズが大きすぎます(10MB以内)')
    elsif !image?
      image.purge
      errors.add(:image, 'ファイルが対応している画像データではありません')
    end
  end

  private

  def image?
    %w[image/jpg image/jpeg image/gif image/png].include?(image.blob.content_type)
  end
end
