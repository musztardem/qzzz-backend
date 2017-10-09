require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:quizzes).dependent(:destroy) }
  it { should have_many(:friendships) }
end
