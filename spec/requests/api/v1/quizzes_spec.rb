require 'rails_helper'

RSpec.describe 'API/V1/Quizzes' do
  let!(:user) { create :user }
  let!(:quizzes_list) { create_list(:quiz, 5, user: user) }
  let!(:empty_user) { create :user }
  let(:headers) { valid_headers }

  describe 'GET /quizzes' do
    context 'unathorized user' do
      before { get '/api/v1/quizzes', headers: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns missing token message' do
        expect(json['message']).to match(/Missing token/)
      end
    end

    context 'authorized user' do
      before { get '/api/v1/quizzes', headers: headers }

      it 'returns current users quizzes' do
        expect(json['quizzes'].size).to eq 5
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /quizzes' do
    let!(:valid_quiz) { attributes_for(:quiz, user: user).to_json }
    let!(:invalid_quiz) { {}.to_json }

    context 'valid params' do
      before { post '/api/v1/quizzes', params: valid_quiz, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Quiz was successfully created/)
      end
    end

    context 'invalid params' do
      before { post '/api/v1/quizzes', params: invalid_quiz, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns error messages' do
        expect(json['messages'].size).to eq(2)
      end
    end
  end

  describe 'PATCH /quizzes/{:quiz_id}' do
    let!(:quiz) { create :quiz, user: user }
    let!(:updated_params) { { title: 'Updated title!', description: 'Updated description!' }.to_json }

    before { patch "/api/v1/quizzes/#{quiz.id}", params: updated_params, headers: headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns success message' do
      expect(json['message']).to match(/Quiz was successfully updated./)
    end
  end

  describe 'DELETE /quizzes/{:id}' do
    let!(:quiz) { create :quiz, user: user }

    before { delete "/api/v1/quizzes/#{quiz.id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'returns empty response' do
      expect(response.body).to eq ''
    end
  end

  describe 'GET /quizzes/user_quizzes/{:user_id}' do
    let!(:other_user) { create :user }

    context "when quiz is invisible" do
      let!(:invisible_quiz) { create :quiz, :invisible, user: other_user }
      before { get "/api/v1/quizzes/user_quizzes/#{other_user.id}", headers: headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'does not return invisible quiz' do
        expect(json['quizzes']).to be_empty
      end
    end

    context "when quiz is visible for friends" do
      let!(:quiz_for_friends) { create :quiz, :visible_for_friends, user: other_user }

      context "when users are friends" do
        let!(:friendship) { create :friendship, user: user, friend: other_user }
        before { get "/api/v1/quizzes/user_quizzes/#{other_user.id}", headers: headers }

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        it 'returns quiz' do
          expect(json['quizzes'].size).to eq 1
        end
      end

      context "when users are not friends" do
        before { get "/api/v1/quizzes/user_quizzes/#{other_user.id}", headers: headers }

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        it 'does not returns quiz' do
          expect(json['quizzes'].size).to eq 0
        end
      end
    end

    context "when quiz is visible for all" do
      let!(:quiz_for_all) { create :quiz, :visible_for_all, user: other_user }
      before { get "/api/v1/quizzes/user_quizzes/#{other_user.id}", headers: headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'does not returns quiz' do
        expect(json['quizzes'].size).to eq 1
      end
    end
  end
end
