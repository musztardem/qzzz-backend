require 'rails_helper'

RSpec.describe QuestionForm do

  context 'when valid attributes' do
    let(:quiz) { create :quiz }
    let(:question) { create :question, quiz: quiz }
    let(:answers) do
      [
        attributes_for(:answer, question_id: question.id),
        attributes_for(:answer, question_id: question.id, correct: false)
      ]
    end
    let(:valid_attributes) { attributes_for(:question, quiz_id: quiz.id, answers: answers) }

    subject { described_class.new(valid_attributes) }

    it 'is valid' do
      expect(subject.valid?).to be true
    end
  end

  context 'when invalid attributes' do
    context 'when empty attributes' do
      let(:empty_attributes) { {} }
      subject { described_class.new(empty_attributes) }

      it 'is invalid' do
        expect(subject.valid?).not_to be true
        expect(subject.errors.count).to eq 4
      end
    end

    context 'when not enough answers' do
      let(:quiz) { create :quiz }
      let(:answers) { [ attributes_for(:answer) ] }
      let(:invalid_attributes) { attributes_for(:question, quiz_id: quiz.id, answers: answers ) }

      subject { described_class.new(invalid_attributes)}

      it 'is invalid' do
        expect(subject.valid?).not_to be true
        expect(subject.errors.count).to eq 1
        expect(subject.errors.full_messages).to include 'should have at least 2 answers.'
      end
    end

    context 'when no correct answers' do
      let(:quiz) { create :quiz }
      let(:question) { create :question, quiz_id: quiz.id }
      let(:answers) do
        [
          attributes_for(:answer, question_id: question.id, correct: false),
          attributes_for(:answer, question_id: question.id, correct: false)
        ]
      end
      let(:invalid_attributes) { attributes_for(:question, quiz_id: quiz.id, answers: answers) }
      subject { described_class.new(invalid_attributes) }

      it 'is invalid' do
        expect(subject.valid?).not_to be true
        expect(subject.errors.count).to eq 1
        expect(subject.errors.full_messages).to include 'should have at least one correct answer.'
      end
    end
  end
end
