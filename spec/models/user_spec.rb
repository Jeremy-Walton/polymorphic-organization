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

  context '.alphabetically' do
    it 'returns users alphabetically by name' do
      expect(User.alphabetically).to eq [ users(:gavin), users(:jeremy), users(:john), users(:michael) ]
    end
  end

  context '#first_name' do
    it 'returns the users first name' do
      expect(users(:jeremy).first_name).to eq 'Jeremy'
      expect(users(:michael).first_name).to eq 'Michael'
    end
  end

  context '#last_name' do
    it 'returns the users last name' do
      expect(users(:jeremy).last_name).to eq 'Walton'
      expect(users(:michael).last_name).to eq 'Hale'
    end
  end

  context '#initials' do
    it 'returns the users initials' do
      expect(users(:jeremy).initials).to eq 'JW'
      expect(users(:john).initials).to eq 'JCY'
    end
  end
end
