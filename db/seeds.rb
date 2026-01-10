# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

unless Rails.env.development?
  puts "WARN: Seeding is just for development!"
else
  def create_user(name, email_address)
    User.create_with(name:, password: 'Password123password').find_or_create_by!(email_address:)
  end

  def create_feed(name)
    Feed.find_or_create_by!(name:)
  end

  def create_podcast(name)
    Podcast.find_or_create_by!(name:)
  end

  def create_newspaper(name)
    Newspaper.find_or_create_by!(name:)
  end

  def subscribe_to_podcast(subscriber, podcast)
    subscriber.podcasts << podcast
  end

  def subscribe_to_newspaper(subscriber, newspaper)
    subscriber.newspapers << newspaper
  end

  def create_feed_membership(user, feed, role: :member)
    feed.feed_users.find_or_create_by(user:, role:).tap do |feed_user|
      feed_user.active = true
    end
    feed.save
  end

  jeremy = create_user "Jeremy Walton", "jeremy@rolemodelsoftware.com"
  michael = create_user "Michael Hale", "michael@rolemodelsoftware.com"
  gabe = create_user "Gabe Lewis", "gabe@sabre.com"
  jo = create_user "Jo Bennett", "jo@sabre.com"

  rolemodel_feed = create_feed "RoleModel Info"
  sabre_feed = create_feed "Sabre Info"

  ndq = create_podcast "No Dumb Questions"
  syntax = create_podcast "Syntax. Tasty Web Development Treats"

  morning_times = create_newspaper "Morning Times"
  news_and_observer = create_newspaper "The News & Observer"

  # RMS Feed
  subscribe_to_newspaper rolemodel_feed, news_and_observer
  subscribe_to_podcast rolemodel_feed, syntax

  create_feed_membership(jeremy, rolemodel_feed, role: :owner)
  create_feed_membership(michael, rolemodel_feed)

  # Sabre Feed
  subscribe_to_newspaper sabre_feed, morning_times
  subscribe_to_podcast sabre_feed, ndq

  create_feed_membership(jo, sabre_feed, role: :owner)
  create_feed_membership(gabe, sabre_feed, role: :admin)

  # Jeremy subscriptions
  subscribe_to_podcast jeremy, ndq
  subscribe_to_podcast jeremy, syntax
  subscribe_to_newspaper jeremy, news_and_observer

  # Michael subscriptions
  subscribe_to_podcast michael, syntax
  subscribe_to_newspaper michael, morning_times

  # Gabe subscriptions
  subscribe_to_podcast gabe, ndq
  subscribe_to_podcast gabe, syntax

  # Jo subscriptions
  subscribe_to_podcast jo, syntax
  subscribe_to_newspaper jo, news_and_observer
end
