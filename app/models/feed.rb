class Feed < ApplicationRecord
  include Memberable, Subscriber

  validates :name, presence: true
end
