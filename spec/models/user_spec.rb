require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users

  context 'normalizes' do
    it 'normalizes the email address' do
      user = User.build(email_address: 'TEST@exaMPLE.com')
      expect(user.email_address).to eq 'test@example.com'
    end
  end

  context 'validations' do
    let(:user) { User.build }

    it 'is invalid without required attributes' do
      expect(user).to be_invalid
      expect(user.errors[:name]).to include "can't be blank"
      expect(user.errors[:password]).to include "can't be blank"
      expect(user.errors[:email_address]).to include "can't be blank"
    end
  end

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
