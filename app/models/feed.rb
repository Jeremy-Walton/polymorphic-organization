class Feed < ApplicationRecord
  has_many :subscriptions, as: :subscriber, dependent: :destroy
  has_many :podcasts, through: :subscriptions, source: :subscribable, source_type: "Podcast"
  has_many :newspapers, through: :subscriptions, source: :subscribable, source_type: "Newspaper"

  has_many :feed_users
  has_many :users, through: :feed_users

  validates :name, presence: true

  def member_count
    users.count
  end
end
