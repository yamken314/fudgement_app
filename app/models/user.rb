class User < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :profile_image
  has_many :choices
  has_many :microposts, dependent: :destroy
  has_many :votes
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy,
                                  inverse_of: :follower
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy,
                                   inverse_of: :followed
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  attr_accessor :remember_token
  validates :name, presence: true, length: { maximum: 50 }, unless: :uid?
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save :downcase_email, unless: :uid? 
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false },
                    unless: :uid?
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :password, unless: :uid?

  def downcase_email
    self.email = email.downcase
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    self.update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    self.update_attribute(:remember_digest, nil)
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def voted?(choice)
    votes.where(choice_id: choice.id).exists?
  end

  private
  
  def self.guest
    find_or_create_by!(name: 'ゲスト',email: 'guest1@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    image = auth[:info][:image]
    image_url = auth[:info][:image]
    uri = URI.parse(image_url)
    image = uri.open
    password = SecureRandom.urlsafe_base64
    email = User.dummy_email(auth)
  
    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
      user.avatar.attach(io: image, filename: "#{user.name}_profile.png")
      user.password = password
      user.email = email
    end
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
