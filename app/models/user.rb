class User < ApplicationRecord
  include Named, Subscriber

  has_many :feed_users
  has_many :feeds, through: :feed_users

  has_secure_password

  validates :email_address, :name, :password, presence: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def feed_count
    feeds.count
  end
end
