require 'rails_helper'

RSpec.describe FeedUser, type: :model do
  fixtures :users

  let!(:feed) { Feed.create(name: 'Test Feed') }

  context 'scopes' do
    let!(:jeremy_feed_user) { users(:jeremy).feed_users.create(feed:, role: :owner) }
    let!(:john_feed_user) { users(:john).feed_users.create(feed:, role: :owner, active: false) }
    let!(:gavin_feed_user) { users(:gavin).feed_users.create(feed:, role: :admin) }
    let!(:michael_feed_user) { users(:michael).feed_users.create(feed:, role: :member) }

    context '.owner' do
      it 'returns active owners' do
        expect(feed.feed_users.owner).to eq [ jeremy_feed_user ]
      end
    end

    context '.admin' do
      it 'returns active admins and owners' do
        john_feed_user.update(role: :admin, active: true)
        gavin_feed_user.update(active: false)

        expect(feed.feed_users.reload.admin).to eq [ jeremy_feed_user, john_feed_user ]
      end
    end

    context '.member' do
      it 'returns active members' do
        expect(feed.feed_users.member).to eq [ michael_feed_user ]
      end
    end

    context '.active' do
      it 'returns active feed users' do
        expect(feed.feed_users.active).to eq [ jeremy_feed_user, gavin_feed_user, michael_feed_user ]
      end
    end
  end

  context '#admin?' do
    let!(:feed_user) { users(:jeremy).feed_users.create(feed:, role: :admin) }

    it 'returns true if the feed user is an admin' do
      expect(feed_user).to be_admin
    end

    it 'returns true if the feed user is an owner' do
      feed_user.update(role: :owner)
      expect(feed_user).to be_admin
    end

    it 'returns false if the feed user is not an admin' do
      feed_user.update(role: :member)
      expect(feed_user).not_to be_admin
    end
  end

  context '#deactivate' do
    it 'nils out the user and sets active to false' do
      feed_user = users(:jeremy).feed_users.create(feed:)

      feed_user.deactivate

      expect(feed_user.user).to be_nil
      expect(feed_user).not_to be_active
    end
  end

  context '#can_change?' do
    let!(:feed_user1) { users(:jeremy).feed_users.create(feed:, role: :admin) }
    let!(:feed_user2) { users(:michael).feed_users.create(feed:, role: :admin) }

    it 'returns true if admin and other is not owner' do
      expect(feed_user1.can_change?(feed_user2)).to be_truthy
    end

    it 'returns false if admin and other is owner' do
      feed_user2.update(role: :owner)
      expect(feed_user1.can_change?(feed_user2)).to be_falsey
    end

    it 'returns false if not admin' do
      feed_user1.update(role: :member)
      expect(feed_user1.can_change?(feed_user2)).to be_falsey
    end

    it 'returns true if self' do
      expect(feed_user1.can_change?(feed_user1)).to be_truthy
    end
  end

  context '#can_administer?' do
  let!(:feed_user1) { users(:jeremy).feed_users.create(feed:, role: :admin) }
    let!(:feed_user2) { users(:michael).feed_users.create(feed:, role: :admin) }

    it 'returns true if admin and other is not owner' do
      expect(feed_user1.can_administer?(feed_user2)).to be_truthy
    end

    it 'returns false if admin and other is owner' do
      feed_user2.update(role: :owner)
      expect(feed_user1.can_administer?(feed_user2)).to be_falsey
    end

    it 'returns false if not admin' do
      feed_user1.update(role: :member)
      expect(feed_user1.can_administer?(feed_user2)).to be_falsey
    end

    it 'returns false if self' do
      expect(feed_user1.can_administer?(feed_user1)).to be_falsey
    end
  end
end
