module Feed::Memberable
  extend ActiveSupport::Concern

  included do
    has_many :feed_users
    has_many :users, through: :feed_users
  end

  def member_count
    users.count
  end
end
