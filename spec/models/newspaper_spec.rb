require 'rails_helper'

RSpec.describe Newspaper, type: :model do
  context 'validations' do
    let(:newspaper) { Newspaper.build }

    it 'is invalid without required attributes' do
      expect(newspaper).to be_invalid
      expect(newspaper.errors[:name]).to include "can't be blank"
    end
  end
end
