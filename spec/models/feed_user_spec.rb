require 'rails_helper'

RSpec.describe FeedUser, type: :model do
  fixtures :users

  let!(:feed) { Feed.create(name: 'Test Feed') }

  context '#deactivate' do
    it 'nils out the user and sets active to false' do
      feed_user = users(:jeremy).feed_users.create(feed:)

      feed_user.deactivate

      expect(feed_user.user).to be_nil
      expect(feed_user).not_to be_active
    end
  end
end
