FactoryGirl.define do
  factory :quiz do
    title { Faker::Name.name }
    description { Faker::Name.title }
    user
  end

  trait :visible do
    visible true
  end

  trait :invisible do
    visible false
  end

end
