require 'rails_helper'

RSpec.describe User::Feedable, type: :model do
  fixtures :users

  context '#feed_count' do
    it 'returns the count of associated feeds' do
      feed1 = Feed.create(name: 'Test Feed')
      feed2 = Feed.create(name: 'Another Feed')
      users(:jeremy).feed_users.create(feed: feed1)
      users(:jeremy).feed_users.create(feed: feed2)

      expect(users(:jeremy).feed_count).to eq 2
    end
  end
end
