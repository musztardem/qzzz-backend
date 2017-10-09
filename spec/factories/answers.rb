FactoryGirl.define do
  factory :answer do
    content { Faker::ChuckNorris.fact }
    question
  end
end
