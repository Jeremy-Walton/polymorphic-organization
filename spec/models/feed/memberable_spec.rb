require 'rails_helper'

RSpec.describe Feed::Memberable, type: :model do
  fixtures :users

  context '#member_count' do
    let(:feed) { Feed.create(name: 'Test Feed') }

    it 'returns the count of associated users' do
      feed.feed_users.create(user: users(:jeremy))
      feed.feed_users.create(user: users(:michael))

      expect(feed.member_count).to eq 2
    end
  end
end
