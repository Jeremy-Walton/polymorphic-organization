class Podcast < ApplicationRecord
  include Subscribable

  validates :name, presence: true
end
