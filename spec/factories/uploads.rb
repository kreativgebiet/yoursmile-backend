FactoryGirl.define do
  factory :upload do
    image '#'
    description Faker::Lorem.paragraph

    user
  end
end
