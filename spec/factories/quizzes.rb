FactoryGirl.define do
  factory :quiz do
    title { Faker::Name.name }
    description { Faker::Name.title }
    user
    status :invisible
  end

  trait :invisible do
    status :invisible
  end

  trait :visible_for_friends do
    status :visible_for_friends
  end

  trait :visible_for_all do
    status :visible_for_all
  end
end
