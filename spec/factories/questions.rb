FactoryGirl.define do
  factory :question do
    content { Faker::ChuckNorris.fact }
    quiz
  end
end
