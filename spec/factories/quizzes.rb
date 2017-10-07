FactoryGirl.define do
  factory :quiz do
    title { Faker::RickAndMorty.character }
    description { Faker::RickAndMorty.quote }
    user
  end
end
