class Newspaper < ApplicationRecord
  include Subscribable

  validates :name, presence: true
end
