FactoryGirl.define do
  factory :quiz do
    title { Faker::Name.name }
    description { Faker::Name.title }
    user
  end
end
