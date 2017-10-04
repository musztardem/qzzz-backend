FactoryGirl.define do
  factory :friendship do
    user
    association :friend, factory: :user

    trait :accepted do
      status :accepted
    end

    trait :pending do
      status :pending
    end
  end
end
