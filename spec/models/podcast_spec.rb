require 'rails_helper'

RSpec.describe Podcast, type: :model do
  context 'validations' do
    let(:podcast) { Podcast.build }

    it 'is invalid without required attributes' do
      expect(podcast).to be_invalid
      expect(podcast.errors[:name]).to include "can't be blank"
    end
  end
end
