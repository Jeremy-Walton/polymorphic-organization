class FeedUser < ApplicationRecord
  belongs_to :feed
  belongs_to :user, optional: true

  enum :role, { owner: "owner", admin: "admin", member: "member", system: "system" }, scopes: false

  scope :owner, -> { where(active: true, role: :owner) }
  scope :admin, -> { where(active: true, role: %i[ owner admin ]) }
  scope :member, -> { where(active: true, role: :member) }
  scope :active, -> { where(active: true, role: %i[ owner admin member ]) }

  def admin?
    super || owner?
  end

  def deactivate
    update! active: false, user: nil
  end

  def can_change?(other_feed_user)
    (admin? && !other_feed_user.owner?) || other_feed_user == self
  end

  def can_administer?(other_feed_user)
    admin? && !other_feed_user.owner? && other_feed_user != self
  end
end
