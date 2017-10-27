require 'rails_helper'

RSpec.describe QuizForm do
  context 'when valid attributes' do
    let!(:user) { create :user }
    let(:quiz_attributes) { attributes_for(:quiz, user_id: user.id) }

    subject { described_class.new(quiz_attributes) }

    it 'is valid' do
      expect(subject.valid?).to be true
    end
  end

  context 'when invalid attributes' do
    let(:empty_attributes) { {} }

    subject { described_class.new(empty_attributes) }

    it 'is invalid' do
      expect(subject.valid?).to be false
      expect(subject.errors.size).to eq 3
    end
  end
end
