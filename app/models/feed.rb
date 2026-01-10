class Feed < ApplicationRecord
  has_many :subscriptions, as: :subscriber, dependent: :destroy
  has_many :podcasts, through: :subscriptions, source: :subscribable, source_type: "Podcast"
  has_many :newspapers, through: :subscriptions, source: :subscribable, source_type: "Newspaper"

  validates :name, presence: true
end
