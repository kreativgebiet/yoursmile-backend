FactoryGirl.define do
  factory :upload do
    image {
      Rack::Test::UploadedFile.new(
        File.join(Rails.root, 'spec', 'fixtures', 'test-img-1.png')
      )
    }
    description Faker::Lorem.paragraph

    user { create(:user) }
    supports { [create(:upload_support)] }
  end
end
