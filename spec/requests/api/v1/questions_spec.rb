require 'rails_helper'

RSpec.describe 'API/V1/Questions', type: :request do
  let!(:user) { create :user }
  let!(:headers) { valid_headers }
  let!(:quiz) { create :quiz, user: user }
  let!(:questions) { create_list(:question, 2, quiz: quiz) }
  let!(:answers_one) { create_list(:answer, 4, question: questions.first) }
  let!(:answers_two) { create_list(:answer, 4, question: questions.last) }

  describe 'GET /quizzes/{:quiz_id}/questions' do
    before { get "/api/v1/quizzes/#{quiz.id}/questions", headers: headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns quiz questions' do
      expect(json['questions'].size).to eq 2
    end
  end

  describe 'POST /quizzes/{:quiz_id}/questions' do
    context 'valid params' do
      let!(:valid_params) { attributes_for(:question).to_json }
      before { post "/api/v1/quizzes/#{quiz.id}/questions", params: valid_params, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Question was successfully created/)
      end
    end

    context 'invalid params' do
      let!(:invalid_params) { attributes_for(:question, content: '').to_json }
      before { post "/api/v1/quizzes/#{quiz.id}/questions", params: invalid_params, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error messages' do
        expect(json['messages'].size).to eq 1
      end
    end
  end

  describe 'GET /quizzes/{:quiz_id}/questions/{:id}' do
    before { get "/api/v1/quizzes/#{quiz.id}/questions/#{questions.first.id}", headers: headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns question' do
      expect(json).not_to be_empty
    end

    it 'returns question answers' do
      expect(json['answers']).not_to be_empty
    end
  end

  describe 'PATCH /quizzes/{:quiz_id}/questions/{:id}' do
    let!(:valid_params) { attributes_for(:question, content: 'New content!').to_json }
    before { patch "/api/v1/quizzes/#{quiz.id}/questions/#{questions.last.id}", params: valid_params, headers: headers }

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns success message' do
      expect(json['message']).to match(/Question was successfully updated/)
    end
  end

  describe 'DELETE /quizzes/{:quiz_id}/questions/{:id}' do
    before { delete "/api/v1/quizzes/#{quiz.id}/questions/#{questions.last.id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
