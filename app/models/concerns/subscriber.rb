module Subscriber
  extend ActiveSupport::Concern

  included do
    has_many :subscriptions, as: :subscriber, dependent: :destroy

    # FIXME: expose a way for models to register
    # themselves so you don't have to add to this list?
    has_many :podcasts, through: :subscriptions, source: :subscribable, source_type: "Podcast"
    has_many :newspapers, through: :subscriptions, source: :subscribable, source_type: "Newspaper"
  end
end
