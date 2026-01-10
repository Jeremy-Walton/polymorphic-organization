class User < ApplicationRecord
  has_many :subscriptions, as: :subscriber, dependent: :destroy
  has_many :podcasts, through: :subscriptions, source: :subscribable, source_type: "Podcast"
  has_many :newspapers, through: :subscriptions, source: :subscribable, source_type: "Newspaper"

  has_secure_password

  scope :alphabetically, -> { order("lower(name)") }

  validates :email_address, :name, :password, presence: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def first_name
    name.split(/\s/).first
  end

  def last_name
    name.split(/\s/, 2).last
  end

  def initials
    name.scan(/\b\p{L}/).join.upcase
  end
end
