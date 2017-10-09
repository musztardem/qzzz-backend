require 'rails_helper'

RSpec.describe 'API/V1/Questions', type: :request do
  let!(:user) { create :user }
  let!(:headers) { valid_headers }
  let!(:quiz) { create :quiz }
  let!(:questions) { create_list(:question, 2, quiz: quiz) }

  before do
    create_list(:answer, 4, questions.first)
    create_list(:answer, 4, questions.last)
  end

  describe 'GET /quizzes/{:quiz_id}/questions' do
    it 'returns status code 200'
    it 'returns quiz questions'
  end

  describe 'POST /quizzes/{:quiz_id}/questions' do
    context 'valid params' do
      it 'returns status code 201'
      it 'returns success message'
    end

    context 'invalid params' do
      it 'returns status code 422'
      it 'returns error messages'
    end
  end

  describe 'GET /quizzes/{:quiz_id}/questions/{:id}' do
    it 'returns status code 200'
    it 'returns question'
    it 'returns question answers'
  end

  describe 'PATCH /quizzes/{:quiz_id}/questions/{:id}' do
    it 'return status code 200'
    it 'returns success message'
  end

  describe 'DELETE /quizzes/{:quiz_id}/questions/{:id}' do
    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
