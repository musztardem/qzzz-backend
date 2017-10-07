require 'rails_helper'

RSpec.describe 'API/V1/Quizzes' do
  let!(:user) { create :user }
  let!(:quizzes_list) { create_list(:quiz, 5, user: user) }
  let!(:empty_user) { create :user }
  let(:headers) { valid_headers }

  describe 'GET /quizzes' do
    context 'unathorized user' do
      before { get '/api/v1/quizzes', headers: {} }

      it 'returns something' do
        binding.pry
      end
    end

    context 'authorized user' do
      before { get '/api/v1/quizzes', headers: headers }

      it 'returns something' do
        binding.pry
      end
    end
  end
end
