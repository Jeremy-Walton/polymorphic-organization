class User < ApplicationRecord
  include Feedable, Named, Subscriber

  has_secure_password

  validates :email_address, :name, :password, presence: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
