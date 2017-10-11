require 'rails_helper'

RSpec.describe 'API/V1/Friendships', type: :request do
  let!(:user) { create :user }
  let!(:friends) { create_list(:user, 4) }
  let!(:friendships) { friends.map { |friend| create(:friendship, :accepted, user: user, friend: friend) } }
  let!(:new_friend) { create :user }
  let(:headers) { valid_headers }


  describe 'GET /friendships' do
    before { get '/api/v1/friendships', headers: headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns friends list' do
      expect(json.count).to eq(4)
    end
  end

  describe 'POST /friendships' do
    context 'when friendship does not exist' do
      let(:valid_attributes) { { friend_id: new_friend.id }.to_json }
      before { post '/api/v1/friendships', params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Invitation has been sent/)
      end
    end

    context 'when friendship exists' do
      context 'when has pending status' do
        let!(:friendship) { create(:friendship, :pending, user: new_friend, friend: user) }
        let(:valid_attributes) { { friend_id: friendship.friend_id }.to_json }

        before { post '/api/v1/friendships', params: valid_attributes, headers: headers }

        it 'return status code 200' do
          expect(response).to have_http_status(201)
        end

        it 'returns success message' do
          expect(json['message']).to match(/Invitation has been sent/)
        end
      end

      context 'when has accepted status' do
        let!(:friendship) { create(:friendship, :accepted, user: user, friend: new_friend) }
        let(:valid_attributes) { { friend_id: new_friend.id }.to_json }

        before { post '/api/v1/friendships', params: valid_attributes, headers: headers }

        it 'returns status code' do
          expect(response).to have_http_status(422)
        end

        it 'returns error message' do
          expect(json['messages']).to include("Friend is already your friend.")
        end
      end
    end
  end

  describe 'POST /friendships/{:friendship_id}/accept' do
    let!(:inviting_user) { create :user }
    let!(:new_friendship) { create(:friendship, :pending, user: inviting_user, friend: user) }

    before { post "/api/v1/friendships/#{new_friendship.id}/accept", headers: headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'accepts friendship' do
      expect(json['message']).to match(/Invitation has been accepted/)
    end
  end

  describe 'DELETE /friendships/{:friendship_id}' do
    before { delete "/api/v1/friendships/#{friendships.last.id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'returns success message' do
      expect(response.body).to eq ""
    end
  end
end
