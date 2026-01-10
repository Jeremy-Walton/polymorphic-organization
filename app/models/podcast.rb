class Podcast < ApplicationRecord
  has_many :subscriptions, as: :subscribable, dependent: :destroy
  has_many :users, through: :subscriptions, source: :subscriber, source_type: "User"
  has_many :feeds, through: :subscriptions, source: :subscriber, source_type: "Feed"

  validates :name, presence: true
end
