module Subscribable
  extend ActiveSupport::Concern

  included do
    has_many :subscriptions, as: :subscribable, dependent: :destroy

    # FIXME: expose a way for models to register
    # themselves so you don't have to add to this list?
    has_many :users, through: :subscriptions, source: :subscriber, source_type: "User"
    has_many :feeds, through: :subscriptions, source: :subscriber, source_type: "Feed"
  end
end
