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
end
