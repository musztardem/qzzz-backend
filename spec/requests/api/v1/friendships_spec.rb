require 'rails_helper'

RSpec.describe 'API/V1/Friendships', type: :request do
  let!(:user) { create :user }
  let!(:friends) { create_list(:user, 4) }
  let!(:friendships) { friends.map { |friend| create(:friendship, user: user, friend: friend) } }
  let!(:new_friend) { create :user }
  let(:headers) { valid_headers }


  describe 'GET /friendships' do
    before { get '/api/v1/friendships', headers: headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns friends list' do
      expect(json['friends'].count).to eq(4)
    end
  end

  describe 'POST /friendships' do
    context 'when friendship does not exist' do
      let(:valid_attributes) { attributes_for(:friendship, user: user, friend: new_friend) }
      before { post '/api/v1/friendships', params: valid_attributes, headers: headers }

      it 'creates new friendship' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Invitation has been sent/)
      end
    end

    context 'when friendship already exists' do
      let!(:friendship) { create(:friendship, :pending, user: new_friend, friend: user) }
      let(:valid_attributes) { attributes_for(:friendship, user: user, friend: new_friend) }

      before { post '/api/v1/friendships', params: valid_attributes, headers: headers }

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'accepts friendship' do
        expect(json['friendship']['status']).to eq('accepted')
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
      expect(json['friendship']['status']).to eq('accepted')
    end
  end
end
