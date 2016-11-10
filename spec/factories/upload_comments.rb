FactoryGirl.define do
  factory :upload_comment, class: 'Upload::Comment' do
    text Faker::Lorem.sentence

    association :author, factory: :user
  end
end
