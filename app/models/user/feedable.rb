module User::Feedable
  extend ActiveSupport::Concern

  included do
    has_many :feed_users
    has_many :feeds, through: :feed_users
  end

  def feed_count
    feeds.count
  end
end
