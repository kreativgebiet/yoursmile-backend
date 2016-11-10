FactoryGirl.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password 'testtest123'
    password_confirmation 'testtest123'
    nickname { Faker::Internet.user_name }
    name Faker::Name.name

    confirmed_at Date.today
  end
end
