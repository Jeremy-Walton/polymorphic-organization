class FeedUser < ApplicationRecord
  include Role

  belongs_to :feed
  belongs_to :user, optional: true

  def deactivate
    update! active: false, user: nil
  end
end
