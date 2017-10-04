FactoryGirl.define do
  factory :user do
    username { Faker::Name.first_name }
    email 'foo@bar.com'
    password 'foobar'
  end
end
