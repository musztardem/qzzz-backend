require 'rails_helper'

RSpec.describe FriendshipForm do

  context 'when valid attributes' do
    let(:friendship_attributes) { attributes_for(:friendship, user_id: 1, friend_id: 2) }
    subject { described_class.new(friendship_attributes) }

    it 'is valid' do
      expect(subject.valid?).to be true
    end
  end

  context 'when invalid attributes' do
    context 'when empty attributes ' do
      let(:empty_attributes) { {} }
      subject { described_class.new(empty_attributes) }

      it 'is invalid' do
        expect(subject.valid?).to be false
      end
    end

    context 'when friendship already exists' do
      let!(:friendship) { create(:friendship, :accepted) }
      let(:friendship_attributes) do
        attributes_for(
          :friendship,
          user_id: friendship.user_id,
          friend_id: friendship.friend_id
        )
      end

      subject { described_class.new(friendship_attributes)}

      it 'is invalid' do
        expect(subject.valid?).to be false
        expect(subject.errors.full_messages).to include 'Friend is already your friend.'
      end
    end
  end
end
