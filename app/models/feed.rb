class Feed < ApplicationRecord
  include Subscriber

  has_many :feed_users
  has_many :users, through: :feed_users

  validates :name, presence: true

  def member_count
    users.count
  end
end
