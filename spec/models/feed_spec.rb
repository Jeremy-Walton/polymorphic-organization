require 'rails_helper'

RSpec.describe Feed, type: :model do
  fixtures :users

  context 'validations' do
    let(:feed) { Feed.build }

    it 'is invalid without required attributes' do
      expect(feed).to be_invalid
      expect(feed.errors[:name]).to include "can't be blank"
    end
  end

  context '#member_count' do
    let(:feed) { Feed.create(name: 'Test Feed') }

    it 'returns the count of associated users' do
      feed.feed_users.create(user: users(:jeremy))
      feed.feed_users.create(user: users(:michael))

      expect(feed.member_count).to eq 2
    end
  end
end
