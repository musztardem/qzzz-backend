require 'rails_helper'

RSpec.describe 'API/V1/Quesitons' type: :request do
  let!(:user) { create :user }
  let!(:quizzes_list) { create_list :quiz }
  let(:headers) { valid_headers }

  describe 'GET /api/quizzes' do
  end
end
