require 'rails_helper'

RSpec.describe AnswerForm do
  context 'when valid attributes' do
    let(:answer_attributes) { attributes_for(:answer, question_id: 10) }
    subject { described_class.new(answer_attributes) }

    it 'is valid' do
      expect(subject.valid?).to be true
    end
  end

  context 'when invalid attributes' do
    context 'empty attributes' do
      let(:empty_attributes) { {} }
      subject { described_class.new(empty_attributes) }

      it 'is invalid' do
        expect(subject.valid?).to be false
        expect(subject.errors.count).to eq 2
      end
    end
  end
end
